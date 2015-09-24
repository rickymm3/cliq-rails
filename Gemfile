source "https://rubygems.org"
gem "rails", "4.2"
gem 'rails_12factor', group: :production

# Use PostgreSQL as the database for Active Record
gem "pg", :require => "pg"

# Compressor of JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# Use jQuery as the JavaScript library
gem "jquery-rails"
gem 'jquery-minicolors-rails'

# User authentication
gem 'devise', :git => 'https://github.com/plataformatec/devise.git', :branch => 'lm-rails-4-2'
gem "omniauth-facebook"
gem "kaminari"
gem "ransack"
gem "dynamic_form"
gem 'simple_form'
gem 'ckeditor_rails'
gem 'friendly_id'
gem 'figaro'
gem 'impressionist'
gem 'merit'
gem 'sass-rails'
gem 'whenever', :require => false
gem 'httparty'
gem 'bootstrap-slider-rails'
gem 'filterrific' #, path: '../filterrific'

group :test, :development do
  gem "rspec-rails"
  gem "awesome_print"
end

group :development do
  gem "chronic"
  gem "admin_view"
end

group :test do
  gem "factory_girl_rails"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "capybara"
  gem "shoulda"
  gem "email_spec"
end

group :production, :development do
  gem "thin"
end

gem 'haml-rails'
gem 'better_errors',      group: :development
gem "binding_of_caller"
gem "bower-rails"

gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails", :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', branch:'bootstrap3'
gem "therubyracer"

gem 'will_paginate', '~> 3.0'
gem 'ancestry'
gem 'seed_dump'
gem 'cancancan'
gem 'pry'