# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bootsnap', '>= 1.4.4', require: false
# Use Bulma CSS
gem 'bulma_form_builder'
gem 'bulma-rails', '~> 0.9.3'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'kaminari', '~> 1.2', '>= 1.2.2'
# Missing dependency on Mailer gem in Ruby 3.1.0
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false
gem 'pg', '~> 1.1'
# Premailer inlines CSS to emails and generates text variants of HTML emails.
gem 'premailer-rails'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'pry-rails'
  gem 'rubocop', '1.25.1'
  gem 'rubocop-rails', '2.13.2'
  gem 'rubocop-rspec', '2.8.0'
  # Tests
  gem 'capybara', '~> 3.36'
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.1'
  gem 'shoulda-matchers', '~> 5.1'
  gem 'webdrivers', '~> 5.0', require: false
end

group :development do
  gem 'letter_opener'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
