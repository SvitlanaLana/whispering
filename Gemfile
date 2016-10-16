source 'https://rubygems.org'

gem 'rake'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'activerecord', "~>3.2.17"

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
end

group :test do
  gem 'rspec-sinatra'
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'unicorn'
end

ruby "2.1.2"
