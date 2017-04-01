module API::V1::Admin
  class AdsController < AdminController
    resource_description { short '管理介面 廣告 API' }

    before_action find_record, only: %i(destroy show update)

    api :GET, '/admin/ads', 'List all ads'
    def index
      success do
        paginated_with_meta Ad.all.new_to_old
      end
    end

    def_param_group :ad_params do
      param :title, String, required: true
      param :position, Ad.positions.keys, desc: '廣告位置'
      param :link, String, desc: '廣告的目標鏈接'
      param :picture, String, desc: '廣告圖片'
      param :active_at, DateTime, desc: '廣告展示生效時間'
      param :active_through, DateTime, desc: '廣告展示結束時間'
    end

    api :POST, '/admin/ads', 'Create an ad'
    param_group :ad_params
    def create
      created Ad.create(ad_params)
    end

    api :GET, '/admin/ads/:id', 'Show details for an ad'
    def show
      success(serializer: AdminAdSerializer) { @ad }
    end

    api :PUT, '/admin/ads/:id', 'Modify an ad'
    param_group :ad_params
    def update
      Ad.update_attributes(ad_params)
      updated
    end

    api :DELETE, '/admin/ads/:id', 'Modify an ad'
    def destroy
      @ad.destroy
      updated
    end

    private

    def ad_params
      params.permit(
        :title,
        :position,
        :link,
        :picture,
        :active_at,
        :active_through
      )
    end
  end
end
