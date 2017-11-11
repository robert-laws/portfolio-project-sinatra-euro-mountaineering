class HikersController < ApplicationController
  get "/hikers" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      erb :'hikers/index'
    else
      redirect("/login")
    end
  end

  get "/hikers/edit" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      erb :'hikers/edit_hiker'
    else
      redirect("/login")
    end
  end

  post "/hikers/edit" do
    if params[:first_name] == "" || params[:last_name] == "" || params[:email] == ""
      redirect("/hikers/edit")
    else
      @hiker = Hiker.find(session[:hiker_id])
      @hiker.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], club_id: params[:club_id])
      redirect("/hikers")
    end
  end

  get "/hikers/show/:mountain_id" do
    @hiker = Hiker.find(session[:hiker_id])
    @mountain = Mountain.find(params[:mountain_id])
    @details = HikerMountain.find_by(hiker_id: @hiker.id, mountain_id: @mountain.id)

    erb :'hikers/show'
  end

  get "/hikers/edit/:mountain_id" do
    @hiker = Hiker.find(session[:hiker_id])
    @mountain = Mountain.find(params[:mountain_id])
    @details = HikerMountain.find_by(hiker_id: @hiker.id, mountain_id: @mountain.id)

    erb :'hikers/edit'
  end

  get "/hikers/new" do
    erb :'hikers/new'
  end
end