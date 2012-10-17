source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'asset_sync'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass-rails'
  gem 'font-awesome-sass-rails'
  gem 'jquery-rails'
end

group :development do
  gem 'mailcatcher'

  # Deploy with Capistrano
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'capistrano_colors'
end

group :deployment, :development do
  gem 'foreman'
end

gem 'bullet'
gem 'haml-rails'
gem 'jquery-rails-cdn'
gem 'devise'
gem 'simple_form'
gem 'airbrake'
gem 'responders'
gem 'cocoon'
gem 'rfc-822'
gem 'guid'
gem 'premailer-rails3'
gem 'hpricot'
gem 'simple_enum'

# Sidekiq
gem 'sidekiq'
gem 'sinatra', :require => false
gem 'slim'

# Rails 4.0 backports
# gem 'turbolinks'
# gem 'jquery-turbolinks'
gem 'strong_parameters'
gem 'turbo-sprockets-rails3'


# ActiveAdmin
gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'


group :test, :development do
  gem 'dotenv'
  gem 'rspec-rails'
end

# Use unicorn as the app server
gem 'unicorn'
