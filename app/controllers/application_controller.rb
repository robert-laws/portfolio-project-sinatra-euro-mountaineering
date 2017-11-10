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
    @valid = {un: "", pw: ""}
    erb :login
  end

  post "/login" do
    @valid = {un: "", pw: ""}
    @result = false

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
      # authenticate hiker
      @hiker = Hiker.find_by(username: params[:username])
      if @hiker && @hiker.authenticate(params[:password])
        session[:hiker_id] = @hiker.id
        redirect("/hikers/#{@hiker.id}")
      else
        erb :login
      end
    else
      erb :login
    end
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
    params[:email] == "" ? @valid[:em] = "* enter a valid email" : @valid[:em] = ""
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
      @hiker = Hiker.find_by(username: params[:username])
      if @hiker == nil
        @h = Hiker.create(params)
        redirect("/hikers/#{@h.id}")
      else
        erb :signup
      end
    else
      erb :signup
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:hiker_id]
    end

    def current_user
      User.find(session[:hiker_id])
    end
  end
end
