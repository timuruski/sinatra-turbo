require "bundler/setup"
require "sqlite3"
require "fileutils"

task default: [:start]

task :start do
  exec "bundle exec rerun app.rb"
end

require_relative "env"

task :console do
  require "irb"
  require "irb/completion"
  ARGV.clear

  IRB.start
end

namespace :db do
  task :create do
    DB.run <<-SQL
      CREATE TABLE IF NOT EXISTS items (
        id INTEGER PRIMARY KEY,
        name VARCHAR(255) NOT NULL
      );
    SQL
  end

  task :drop do
    File.unlink(DATABASE_PATH) if File.exist?(DATABASE_PATH)
  end

  task :reset => [:drop, :create]
end
