require 'capybara/rails'
require 'capybara/rspec'
require 'webdrivers'

Selenium::WebDriver.logger.ignore(:browser_options)

Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless
