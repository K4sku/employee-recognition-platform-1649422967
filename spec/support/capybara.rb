require 'capybara/rails'
require 'capybara/rspec'
require 'webdrivers'

Selenium::WebDriver.logger.ignore(:browser_options)
Capybara.configure do |config|
  config.test_id = 'test_id'
end

# register :selenium_chrome_headless with larger then default windw size to use un-collapsed UI (breakpoint is 1024px)
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  [
    'headless',
    'window-size=1280,1280',
    'disable-gpu' # https://developers.google.com/web/updates/2017/04/headless-chrome
  ].each { |arg| options.add_argument(arg) }

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
