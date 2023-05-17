require "bundler/setup"
require "sinatra"

class Banner < Struct.new(:id)
  DB = {
    "123" => Banner.new(id: "123"),
    "234" => Banner.new(id: "234"),
    "345" => Banner.new(id: "345")
  }

  def self.find(id)
    DB.fetch(id)
  end

  def self.each(&block)
    DB.each do |_, banner|
      yield banner
    end
  end

  def timestamp
    Time.now.strftime("%r")
  end

  def dom_id
    "banner_#{id}"
  end
end

helpers do
  def turbo_request?
    request["Turbo-Frame"] == "true"
  end
end

get "/" do
  erb :homepage
end

get "/banner/:id" do
  banner = Banner.find(params[:id])
  erb :banner, locals: { banner: banner }, layout: !turbo_request?
rescue KeyError
  halt 404, "Not found"
end
