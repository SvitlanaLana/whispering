require 'rubygems'
require 'bundler'
require 'active_record'
require "sinatra/activerecord"
# require 'yaml'

RACK_ENV ||= ENV['RACK_ENV'] || "development"

Bundler.require

require './config/environments'

# db_config = YAML.load(ERB.new(File.read('config/database.yml')).result)
# ActiveRecord::Base.establish_connection db_config[RACK_ENV]

Dir.mkdir('log') if !File.exist?('log') || !File.directory?('log')
ActiveRecord::Base.logger = Logger.new(File.open("log/#{RACK_ENV}.log", 'a+'))

(Dir['models/**/*.rb'] + Dir['workers/**/*.rb']).each do |path|
  require_relative path
end

require './app.rb'
