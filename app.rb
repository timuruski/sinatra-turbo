require "sinatra"

require_relative "env"

module Helpers
  module TurboHelper
    def turbo_request?
      !!request.get_header("HTTP_TURBO_FRAME")
    end
  end
end

helpers Helpers::TurboHelper
mime_type(:turbo_stream, "text/vnd.turbo-stream.html")
enable :method_override

get "/" do
  redirect "/items"
end

get "/items/?" do
  items = Item.all
  erb :"items/index", locals: { items: items }
end

get "/items/new" do
  item = Item.new
  erb :"items/new", locals: { item: item }
end

post "/items/?", provides: :turbo_stream do
  item = Item.create(name: params.dig(:item, :name))
  erb :"items/create.turbo_stream", locals: { item: item }, layout: false
end

post "/items/?" do
  item = Item.create(name: params.dig(:item, :name))
  redirect "/items/#{item.id}"
end

get "/items/:id" do
  item = Item[params[:id]]
  erb :"items/show", locals: { item: item }, layout: !turbo_request?
end

get "/items/:id/edit" do
  item = Item[params[:id]]
  erb :"items/edit", locals: { item: item }, layout: !turbo_request?
end

put "/items/:id" do
  item = Item[params[:id]]
  item.update(name: params.dig(:item, :name))

  if turbo_request?
    erb :"items/show", locals: { item: item }, layout: false
  else
    redirect "/items/#{item.id}"
  end
end

delete "/items/:id", provides: :turbo_stream do
  item = Item[params[:id]]
  item.destroy

  erb :"items/destroy.turbo_stream", locals: { item: item }, layout: false
end

delete "/items/:id" do
  item = Item[params[:id]]
  item.destroy

  redirect "/items"
end
