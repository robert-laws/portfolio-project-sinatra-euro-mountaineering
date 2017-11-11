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

      erb :'hikers/show'
    else
      redirect("/login")
    end
  end

  get "/hikers/edit/:id" do
    if logged_in?
      @hiker = Hiker.find(session[:hiker_id])
      @hm = HikerMountain.find(params[:id])
      hike_date = @hm.hike_date.to_s.split("-")
      @year = hike_date[0]
      @month = hike_date[1]
      @day = hike_date[2].split(" ")[0]

      erb :'hikers/edit'
    else
      redirect("/login")
    end
  end

  post "/hikers/edit/:id" do
    if params[:comments] == ""
      redirect("/hikers/edit/#{params[:id]}")
    else
      date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      mountain_id = params[:mountain_id]
      @hm = HikerMountain.find(params[:id])
      @hm.update(hiker_id: session[:hiker_id], mountain_id: params[:mountain_id], comments: params[:comments], hike_date: date)
      redirect("/hikers/show/#{@hm.id}")
    end
  end

  get "/hikers/new" do
    if logged_in?
      erb :'hikers/new'
    else
      redirect("/login")
    end
  end

  post "/hikers/new" do
    if params[:comments] == ""
      redirect("/hikers/new")
    else
      date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      mountain_id = params[:mountain_id]
      @hm = HikerMountain.create(hiker_id: session[:hiker_id], mountain_id: params[:mountain_id], comments: params[:comments], hike_date: date)
      redirect("/hikers/show/#{@hm.id}")
    end
  end
end