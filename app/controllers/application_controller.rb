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
    erb :login
  end

  post "/login" do
    if form_filled_in?(params)
      @hiker = Hiker.find_by(username: params[:username])
      if @hiker && @hiker.authenticate(params[:password])
        session[:hiker_id] = @hiker.id
        redirect("/hikers")
      else
        @error_message = "* Login Error, please try again."
        erb :login
      end
    else
      @error_message = "* Please fill in all the form fields."
      erb :login
    end
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if form_filled_in?(params)
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
        @error_message = "* User account already exists."
        erb :signup
      end
    else
      @error_message = "* Please fill in all the form fields."
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

    def form_filled_in?(form_fields)
      form_fields.each {|key, value| break if value == "" }
    end
  end
end
