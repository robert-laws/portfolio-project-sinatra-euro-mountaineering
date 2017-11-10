require 'pry'

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

  get "/signup" do
    @valid = {fn: "", ln: "", em: "", un: "", pw: ""}
    erb :signup
  end

  post "/signup" do
    @valid = {fn: "", ln: "", em: "", un: "", pw: ""}
    @result = false

    params[:first_name] == "" ? @valid[:fn] = "* enter a valid first name" : @valid[:fn] = ""
    params[:last_name] == "" ? @valid[:ln] = "* enter a valid last name" : @valid[:ln] = ""
    params[:user_email] == "" ? @valid[:em] = "* enter a valid email" : @valid[:em] = ""
    params[:username] == "" ? @valid[:un] = "* enter a valid username" : @valid[:un] == ""
    params[:password] == "" ? @valid[:pw] = "* enter a valid password" : @valid[:pw] == ""
    
    @valid.each do |k, v|
      if v == ""
        @result = true
      else
        @result = false
        break
      end
    end

    if @result
      # create Hiker and save to database
      erb :'hiker/show'
    else
      erb :signup
    end
  end
end
