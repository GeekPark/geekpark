require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Geekpark
  class Application < Rails::Application
    config.generators do |g|
      g.assets false
      g.helper false
    end

    config.middleware.use Rack::Attack
    config.middleware.use Rack::Cors

    config.active_job.queue_adapter = :sidekiq
  end
end
