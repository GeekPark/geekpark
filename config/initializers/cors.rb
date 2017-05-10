middleware = Rails.application.config.middleware
middleware.insert_before 0, Rack::Cors do
  allow do
    origins SiteConfig.cors_allowed_origins
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head]
  end
end
