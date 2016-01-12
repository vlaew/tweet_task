source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'spring'

  gem 'quiet_assets'
  gem 'pry-rails'

  gem 'better_errors' # better errors pages
  gem 'binding_of_caller' # console for better errors

  gem 'rubocop', require: false # Style code analyzer
end

group :test do
  gem 'rspec-rails', '~> 3.0' # Test framework
  gem 'rspec-its', '~> 1.2' # For RSpec 'its' feature
  gem 'guard-rspec', require: false # Auto test
  gem 'factory_girl_rails' # Firxture replacement, test data generator
  gem 'ffaker', '~> 2.1' # For random test data generation
  gem 'database_cleaner' # Cleans database before and after tests
  gem 'simplecov', require: false # code coverage
end
