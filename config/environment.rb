require 'bundler'
Bundler.require

DB = { :conn => SQLite3::Database.new('db/soil_sample.db') }.freeze

require_all 'lib'
