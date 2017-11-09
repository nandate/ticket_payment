require "capybara/poltergeist"
require "capybara-screenshot/rspec"
Capybara.asset_host = "http://localhost:3000"
Capybara.JavaScript_driver = :poltergeist
