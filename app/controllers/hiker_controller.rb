class HikerController < ApplicationController
  get "/hiker" do
    if logged_in?
      @hiker = @current_user
      @hikes = Hike.where(hiker_id: @hiker.id)
      erb :'hiker/index'
    else
      redirect("/login")
    end
  end

  get "/hiker/edit" do
    if logged_in?
      @hiker = @current_user
      erb :'hiker/edit'
    else
      redirect("/login")
    end
  end

  post "/hiker/edit" do
    if logged_in?
      @hiker = @current_user
      if form_filled_in?(params)
        @hiker.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], club_id: params[:club_id])
        redirect("/hiker")
      else
        redirect("hiker/edit")
      end
    else
      redirect("/login")
    end
  end
end