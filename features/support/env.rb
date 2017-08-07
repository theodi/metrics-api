# Generated by cucumber-sinatra. (2013-12-03 12:11:29 +0000)

require 'coveralls'
Coveralls.wear_merged!

require 'dotenv'
Dotenv.load

ENV['RACK_ENV'] = 'test'
ENV['METRICS_API_USERNAME'] = 'foo'
ENV['METRICS_API_PASSWORD'] = 'bar'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/bothan.rb')

require 'capybara'
require 'capybara/cucumber'
require 'selenium/webdriver'
require 'geckodriver/helper'
require 'capybara-webkit'
require 'rspec'
require 'cucumber/api_steps'
require 'cucumber/rspec/doubles'
require 'database_cleaner'
require 'database_cleaner/cucumber'
require 'timecop'

DatabaseCleaner.strategy = :truncation

# TODO HEADLESS CHROME "SOLUTION"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, options = {browser: :chrome})
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new (app, options = {browser: :chrome, desired_capabilities: capabilities})
end

Capybara.javascript_driver = :headless_chrome

# TODO CAPYBARA WEBKIT SOLUTION

# Capybara.javascript_driver = :webkit # not sure why this isn't enabled, doesnt impede existing features
# Capybara::Webkit.configure do |config|
#   config.allow_url("0.0.0.0")
#   # used for pathing for dashboard tests (see below .app_host)
#   config.allow_url("stats.pusher.com")
#   config.allow_url("js.pusher.com")
#   config.allow_url("cdn.plot.ly")
#   config.allow_url("unpkg.com")
#   config.allow_url("cdnjs.cloudflare.com")
#   config.allow_url("maxcdn.bootstrapcdn.com")
#   config.allow_url("fonts.googleapis.com")
#   config.allow_url("ajax.googleapis.com")
#   # used to ensure that all JS loads for the dashboard
# end

Capybara.app = Bothan::App

class Bothan::AppWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers

  def app
    Bothan::App
  end
end

World do
  Bothan::AppWorld.new
end
