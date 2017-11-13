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

  get "/about" do
    erb :about
  end

  get "/login" do
    @valid = {un: "", pw: ""}
    @mes = ""
    erb :login
  end

  post "/login" do
    @valid = {un: "", pw: ""}
    @mes = ""
    @result = false

    params[:username] == "" ? @valid[:un] = "*" : @valid[:un] == ""
    params[:password] == "" ? @valid[:pw] = "*" : @valid[:pw] == ""

    @valid.each do |k, v|
      if v == ""
        @result = true
        @mes = ""
      else
        @result = false
        @mes = "Please correct the problems marked with a *"
        break
      end
    end

    if @result
      # authenticate hiker
      @hiker = Hiker.find_by(username: params[:username])
      if @hiker && @hiker.authenticate(params[:password])
        session[:hiker_id] = @hiker.id
        redirect("/hikers")
      else
        erb :login
      end
    else
      erb :login
    end
  end

  get "/signup" do
    @valid = {fn: "", ln: "", em: "", un: "", pw: ""}
    @mes = ""
    erb :signup
  end

  post "/signup" do
    @valid = {fn: "", ln: "", em: "", un: "", pw: ""}
    @mes = ""
    @result = false

    params[:first_name] == "" ? @valid[:fn] = "*" : @valid[:fn] = ""
    params[:last_name] == "" ? @valid[:ln] = "*" : @valid[:ln] = ""
    params[:email] == "" ? @valid[:em] = "*" : @valid[:em] = ""
    params[:username] == "" ? @valid[:un] = "*" : @valid[:un] == ""
    params[:password] == "" ? @valid[:pw] = "*" : @valid[:pw] == ""

    @valid.each do |k, v|
      if v == ""
        @result = true
        @mes = ""
      else
        @result = false
        @mes = "Please correct the problems marked with a *"
        break
      end
    end

    if @result
      # create Hiker and save to database
      @hiker = Hiker.find_by(username: params[:username])
      if @hiker == nil
        @h = Hiker.create(params)
        session[:hiker_id] = @h.id
        redirect("/hikers")
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
