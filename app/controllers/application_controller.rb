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
        @mes = " Please correct the errors"
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
    erb :signup
  end

  post "/signup" do
    # @valid = {fn: "", ln: "", em: "", un: "", pw: ""}
    # @mes = ""
    # @result = false

    # params[:first_name] == "" ? @valid[:fn] = "*" : @valid[:fn] = ""
    # params[:last_name] == "" ? @valid[:ln] = "*" : @valid[:ln] = ""
    # params[:email] == "" ? @valid[:em] = "*" : @valid[:em] = ""
    # params[:username] == "" ? @valid[:un] = "*" : @valid[:un] == ""
    # params[:password] == "" ? @valid[:pw] = "*" : @valid[:pw] == ""

    # @valid.each do |k, v|
    #   if v == ""
    #     @result = true
    #     @mes = ""
    #   else
    #     @result = false
    #     @mes = " Please correct the errors"
    #     break
    #   end
    # end

    @error_messages = []
    params.each do |key, value|
      if value == ""
        @error_messages << "You are missing the #{key} field information."
      end
    end

    if @error_messages.size == 0
      # create Hiker and save to database
      if !Hiker.find_by(username: params[:username], email: params[:email])
        @hiker = Hiker.new(params)
        if @hiker.save
          session[:hiker_id] = @hiker.id
          redirect("/hikers")
        else 
          @error_messages << @hiker.errors.full_messages.to_sentence
          erb :signup
        end
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

  not_found do
    halt 404, "page not found"
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      # memoization 
      @current_user ||= Hiker.find_by(id: session[:hiker_id]) if session[:hiker_id]
    end
  end
end
