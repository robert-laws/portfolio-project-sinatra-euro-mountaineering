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

  get "/hikes/:id/edit" do
    if logged_in?
      if @hike = current_user.hikes.find_by(id: params[:id])
        hike_date = @hm.hike_date.to_s.split("-")
        @year = hike_date[0]
        @month = hike_date[1].to_i.to_s
        @day = hike_date[2].split(" ")[0].to_i.to_s
        erb :'hikers/edit'
      else
        redirect("/hikers")
      end
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

  get "/hikes/new" do
    if logged_in?
      erb :'hikers/new'
    else
      redirect("/login")
    end
  end

  post "/hikes" do
    if params[:comments] == ""
      redirect("/hikers/new")
    else
      date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      mountain_id = params[:mountain_id]
      @hike = current_user.hikes.build(mountain_id: params[:mountain_id], comments: params[:comments], hike_date: date)
      redirect("/hikers/show/#{@hm.id}")
    end
  end

  patch "/hikes/:id" do 
    
  end

  delete "/hikes/:id" do
    if logged_in?
      @hm = HikerMountain.find(params[:id])
      # test if the logged-in user can view other user hikes

      @hm.delete
      redirect("/hikers")
    else 
      ..
    end
  end
end

# all routes taht require a logged in user no matter the http verb check if they are logged in
# if editing something tha belong to a specific user then you want to make sure it belongs to the speicfic user making the request