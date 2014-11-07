# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
require 'rspec/rails'
# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

# Test coverage
SimpleCov.start 'rails'

RSpec.configure do |config|

  # Pretty FactoryGirl syntax
  config.include FactoryGirl::Syntax::Methods
  
  # See Avdi's blog post.
  config.use_transactional_fixtures = false
  
  config.before(:suite) do
    begin 
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean_with :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # Since the web server and the application are running
  # in different threads we need to ensure that there are no
  # database corruptions.
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!
  
  # use webkit as the driver
  Capybara.javascript_driver = :webkit
  
  config.include BrowserHelper
  config.include LoginHelper
end
