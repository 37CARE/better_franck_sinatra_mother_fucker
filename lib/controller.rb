require 'csv'
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save_gossip
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {gossip: Gossip.find("#{params["id"]}"), id: params["id"]}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossip: Gossip.find("#{params["id"]}"), id: params["id"]}
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params["gossip_author"], params["gossip_content"], params["id"])
    redirect "/gossips/#{params["id"]}/"
  end

  post '/gossips/:id/gotoedit/' do
    redirect "/gossips/#{params["id"]}/edit/"
  end

  run! if app_file == $0
end