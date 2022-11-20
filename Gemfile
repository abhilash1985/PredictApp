# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0', '>= 7.0.4'

# Use mysql2 as the database for Active Record
gem 'mysql2'

# Use Postgres in production
gem 'pg', '~> 1.2', '>= 1.2.3'

# Use Puma as the app server
gem 'puma', '~> 5.6'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.0', group: :doc

gem 'devise', github: 'heartcombo/devise', branch: 'main'
gem 'cancancan'
gem 'kaminari'

gem 'carrierwave'
gem 'spreadsheet'
gem 'rails_admin', '3.1.0'
# gem 'jquery-final_countdown-rails'
gem 'nprogress-rails'
gem 'jquery-datatables-rails'
gem 'jquery-datatables'

gem 'awesome_print'

# Mail
gem 'letter_opener'
# gem 'mailcatcher'

# gem 'sendgrid-ruby'

# Cache page
# gem 'actionpack-page_caching'

# gem 'bower-rails'
# gem 'angularjs-rails'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Sprockets
gem 'sprockets', '~> 3.0'

# for the bootstrap
gem 'bootstrap-sass'#, '>= 3.4.1'
gem 'autoprefixer-rails'
gem 'bootstrap-multiselect-rails'
# gem 'nokogiri'
# gem 'site_prism'

gem 'mimemagic', '0.3.10'

gem 'chartkick'

gem "sprockets-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'pry'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "rack-mini-profiler"

  gem 'listen'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem "spring"

  # gem 'rails_best_practices', require: false
  gem 'rubocop', require: false
  # gem 'rubocop-rspec', require: false
  gem 'brakeman', require: false
  # gem 'flog', require: false
  # gem 'flay', require: false
  # gem 'derailed'
end

group :test do
  ## Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  # gem 'simplecov'
  # gem 'simplecov-rcov'
  # gem 'rspec-rails', '~> 2.0'
  # gem 'factory_girl_rails', '~> 4.0'
  # gem 'capybara'
  # gem 'database_cleaner'
  # # gem 'selenium-webdriver'
  # # Pretty printed test output
  # gem 'turn', :require => false
  # gem 'codeclimate-test-reporter', require: nil
end

# Test Unit
gem 'test-unit'
