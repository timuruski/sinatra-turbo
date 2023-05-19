require "bundler/setup"
require "sequel"
require "sqlite3"

DATABASE_PATH = "development.db"
DB = Sequel.sqlite(DATABASE_PATH)

$LOAD_PATH.unshift(File.expand_path("lib", __dir__))

autoload :Banner, "banner"
autoload :Item, "item"
