module Rack
  class Scal
    def initialize app
      @app = app
    end

    def call env
      request = Rack::Request.new(env)
      stub = local_store.get("access_key:#{request.params[:access_key]}")
      set_params request, stub if stub
      @app.call(env)
    end

    def set_params request, stub
      id, roles = stub.split(':')
      request.update_param('id', id.to_i)
      request.update_param('roles', roles.split(','))
    end


    def remote_storage
      @access_key_redis ||= Redis.new(
        url: ENV['ACCESS_KEY_REDIS_URL'] || 'redis://127.0.0.1/0/master'
      )
    end
  end
end
