require "#{Rails.root}/lib/middleware/extract_user.rb"
Geekpark::Application.config.middleware.use Rack::ExtractUser
