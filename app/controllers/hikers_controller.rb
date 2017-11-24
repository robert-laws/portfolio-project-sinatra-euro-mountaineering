class HikersController < ApplicationController
  get "/hikers" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      @hiker_mountains = HikerMountain.where(hiker_id: @hiker.id)
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

  get "/hikers/show/:id" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      @hm = HikerMountain.find(params[:id])
      if @hiker.id == @hm.hiker_id
        erb :'hikers/show'
      else
        redirect("/hikers")
      end
    else
      redirect("/login")
    end
  end
end