class HikersController < ApplicationController
  get "/hikers" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      erb :'hikers/index'
    else
      redirect("/login")
    end
  end

  get "/hikers/:id/edit" do
    erb :'hikers/edit_hiker'
  end

  get "/hikers/:id/show/:mountain_id" do
    @hiker = Hiker.find(session[:hiker_id])
    @mountain = Mountain.find(params[:mountain_id])
    @details = HikerMountain.find_by(hiker_id: params[:id], mountain_id: params[:mountain_id])

    erb :'hikers/show'
  end

  get "/hikers/:id/edit/:mountain_id" do
    @hiker = Hiker.find(session[:hiker_id])
    @mountain = Mountain.find(params[:mountain_id])
    @details = HikerMountain.find_by(hiker_id: params[:id], mountain_id: params[:mountain_id])

    erb :'hikers/edit'
  end

  get "/hikers/:id/new" do
    erb :'hikers/new'
  end
end