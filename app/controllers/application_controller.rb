class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "euro_secret"
  end

  get "/" do
    erb :index
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    
  end

  get "/account" do
    erb :account
  end

  post "/account" do
    
  end
end
