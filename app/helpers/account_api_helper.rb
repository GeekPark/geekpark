module AccountAPIHelper
  def current_user_roles
    current_user_state&.fetch('roles', nil)&.map(&:intern)
  end

  def current_user_id
    current_user_state&.fetch('id', nil)
  end

  def current_user_state
    return unless params[:access_key]
    cache_json("user_state:#{params[:access_key]}", expires_in: 5.minutes) do
      Internal.get 'users/from_access_key/state',
                   access_key: params[:access_key]
    end
  end

  module Internal
    require 'rest-client'

    def self.get(path, params = {})
      resp = RestClient.get "#{SiteConfig.account_api_base}/#{path}",
                            params: params.merge(csrs: csrs_signature)
      JSON.parse(resp.body)
    rescue
      return nil
    end

    def self.csrs_signature
      timestamp = (Time.now.to_i / 300).to_s(2)
      cross_site_key = SiteConfig.account_csrs_key
      Digest::SHA256.hexdigest(timestamp + cross_site_key)
    end
  end
end
