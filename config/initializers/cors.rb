middleware = Rails.application.config.middleware
middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end

  allow do
    origins '*'              if Rails.env.development?
    origins '*.geekpark.net' if Rails.env.production?

    resource '*',
             headers: :any,
             methods: %i[post put patch delete options head]
  end
end
