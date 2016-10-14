module AccessKeyHelper
  module MockRemoteStorage
    def remote_storage
      MockRemoteStorage
    end

    def self.get(key)
      table[key]
    end

    def self.add(id: 0, roles: [])
      key = SecureRandom.hex(16)
      table["access_key:#{key}"] = "#{id}:#{roles.join(',')}"
      key
    end

    def self.table
      @table ||= {}
    end
  end

  Rack::ExtractUser.prepend MockRemoteStorage

  def access_key_param_for(*args)
    { access_key: access_key_for(*args) }
  end

  def access_key_for(role = nil, id: rand(100_000), roles: [])
    roles = [role] if roles.empty?

    MockRemoteStorage.add(id: id, roles: roles)
  end
end
