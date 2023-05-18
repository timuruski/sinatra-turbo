require "bundler/setup"
require "sequel"
require "sqlite3"

DATABASE_PATH = "development.rb"
DB = Sequel.sqlite(DATABASE_PATH)

$LOAD_PATH.unshift(File.expand_path("lib", __dir__))

autoload :Banner, "banner"
autoload :Item, "item"
