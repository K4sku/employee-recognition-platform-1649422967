require 'capybara/rails'
require 'capybara/rspec'
require 'webdrivers'

Selenium::WebDriver.logger.ignore(:browser_options)
Capybara.configure do |config|
  config.test_id = 'test_id'
end
