source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Core

gem 'orm_adapter' # Provides a single point of entry for using basic features of ruby ORMs
gem 'pg' # Use postgresql as the database for Active Record
gem 'puma', '~> 3.7' # Use Puma as the app server
gem 'rails', '~> 5.1.5' # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# General
gem 'builder'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2' # Use CoffeeScript for .coffee assets and views
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jquery-rails'
gem 'turbolinks', '~> 5' # Makes navigating your web application faster. https://github.com/turbolinks/turbolinks

# Authentication
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', require: 'bcrypt'
gem 'devise'

# Styling/CSS
gem 'bootstrap', '~> 4.0.0'
gem 'font-awesome-sass' # Some stylish glyphicons
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

# Utilities
gem 'carrierwave', '~> 1.0' # File Uploader
gem 'csvpp' # Use CSV++ for processing format and data inputs
gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
gem 'jsoneditor-rails'
gem 'simple_form'

#Validation
gem 'client_side_validations', github: 'DavyJonesLocker/client_side_validations'
gem 'client_side_validations-simple_form', github: 'DavyJonesLocker/client_side_validations-simple_form'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :codereview do
  # Automated Code Review
  # If you are having problems with installing pronto,
  # run `brew install cmake` to install the missing dependency
  gem 'pronto'
  gem 'pronto-flay', require: false
  gem 'pronto-rubocop', require: false
  gem 'rubocop'
end