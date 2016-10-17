require "#{Rails.root}/lib/middleware/extract_user.rb"
Rails.application.config.middleware.use Rack::ExtractUser
