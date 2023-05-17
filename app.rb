require "bundler/setup"
require "sinatra"

get "/" do
  erb :hello_world
end
