source 'https://rubygems.org'

ruby '2.1.3'

gem 'dotenv-rails', group: [:development, :test]

gem 'rails', '4.1.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'haml'
gem 'paperclip'
gem 'aws-sdk' # for paperclip on s3
gem 'settingslogic'
gem 'sorcery'
gem 'octokit', '~> 2.0'
gem 'gemoji'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'puma'
gem 'rack-timeout'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'spring-commands-rspec'
  gem 'priscilla'
  gem 'byebug'
  gem 'coffee-rails-source-maps'
  gem 'better_errors'
  gem 'awesome_print' # better object inspection
  gem 'simplecov'
  gem 'guard'
  gem 'guard-rspec'
end

group :development do
  gem 'foreman'
  # gem 'heroku' replaced by heroku cli.
end

group :staging, :production do
  gem 'rails_12factor' # https://devcenter.heroku.com/articles/rails-integration-gems
  gem 'pg'
end
