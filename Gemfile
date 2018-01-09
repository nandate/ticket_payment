source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'money-rails'
gem 'devise'
gem 'stripe'
gem 'dotenv-rails'
gem 'babel-transpiler'

gem 'delayed_job_active_record'
gem 'rollbar'

gem 'activeadmin', github: "activeadmin/activeadmin"
gem 'active_admin_theme'
gem 'inherited_resources', github: "activeadmin/inherited_resources"
gem 'ransack', github: "activerecord-hackery/ransack"
gem 'draper', "> 3.x"

gem 'pundit'

gem "bootstrap-sass"
gem 'coffee-rails', '~> 4.2'
gem "slim-rails", github: "slim-template/slim-rails"
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'sprockets', github: "rails/sprockets"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'vcr'
  gem 'webmock'
  gem "database_cleaner"
  gem "fake_stripe"
  gem "launchy"
  gem 'poltergeist'
  gem "selenium-webdriver"
  gem "sinatra", github: "sinatra/sinatra"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
