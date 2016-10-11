require "#{Rails.root}/lib/middleware/scal.rb" 
Geekpark::Application::config.middleware.use Rack::Scal
