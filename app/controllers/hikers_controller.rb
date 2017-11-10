class HikersController < ApplicationController
  get "/hikers/:id" do
    @hiker = Hiker.find(session[:hiker_id])
    erb :'hikers/show'
  end

  get "/hikers/:id/edit/:mountain_id" do
    @hiker = Hiker.find(session[:hiker_id])
    @mountain = Mountain.find(params[:mountain_id])
    @details = HikerMountain.find_by(hiker_id: params[:id], mountain_id: params[:mountain_id])

    erb :'hikers/hike'
  end
end