source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'haml-rails'
gem 'bourbon'
gem 'neat'

gem 'mithril_rails'

gem 'rltk'

gem 'websocket-rails'

# OAuth2 login
gem 'dotenv-rails'
gem 'figaro'
gem 'omniauth-google-oauth2'
gem 'activerecord-session_store'

gem 'pleasant-lawyer'

gem 'active_model_serializers', '0.10.0.rc3', github: 'rails-api/active_model_serializers'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'guard-rubocop'
  gem 'guard-cucumber'
  gem 'letter_opener'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'cucumber-rails', require: false
  gem 'shoulda-matchers'
  gem 'rspec-collection_matchers'
end

group :production do
  gem 'rails_12factor'
end
