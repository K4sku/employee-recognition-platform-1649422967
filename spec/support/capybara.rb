require 'capybara/rails'
require 'capybara/rspec'
require 'webdrivers'

Selenium::WebDriver.logger.ignore(:browser_options)

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[--headless --disable-gpu] },
    'goog:loggingPrefs': {
      browser: 'ALL'
    }
  )

  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end

Capybara.default_driver = :headless_chrome
