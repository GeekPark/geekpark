source 'https://gems.ruby-china.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'

# Use postgres as database
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster.
#   Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


gem 'rails-settings-cached'

gem 'rack-cors', require: 'rack/cors'
gem 'rack-attack'
gem 'sidekiq'

# Serialize JSON for API
gem 'active_model_serializers', '~> 0.10'

gem 'redis'

# markdown support
gem 'redcarpet'

# enrich active model
gem 'cant_cant_cant', github: 'shouya/cant_cant_cant' # authentication
# gem 'cant_cant_cant', path: '~/project/cant_cant_cant'
gem 'enumerize'
gem 'kaminari' # pagination
gem 'paranoia'

# for parsing html
gem 'nokogiri'

# for generating api doc
gem 'apipie-rails'

# for uploading files
gem 'carrierwave'
gem 'mini_magick'

# for debugging
gem 'awesome_print'
gem 'byebug', platform: :mri

group :development, :test do
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'guard-rspec', require: false
  gem 'rubocop', require: false
end

group :development do
  # Access an IRB console on exception pages
  #   or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running
  #   in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'awesome_rails_console'
  # Anonate models with db table schemas
  gem 'annotate'

  # no more tail -f development.log,
  #   see https://github.com/dejan/rails_panel
  gem 'meta_request'

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
end

group :test do
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: nil
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
