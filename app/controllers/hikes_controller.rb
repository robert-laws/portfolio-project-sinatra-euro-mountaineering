class HikesController < ApplicationController
  get "/hikes" do
    if logged_in?
      @hiker = @current_user
      @hikes = Hike.where(hiker_id: @hiker.id)
      erb :'hikes/index'
    else
      redirect("/login")
    end
  end

  get "/hikes/new" do
    if logged_in?
      erb :'hikes/new'
    else
      redirect("/login")
    end
  end

  post "/hikes" do
    if logged_in?
      hiker = @current_user
      if form_filled_in?(params)
        date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @hike = hiker.hikes.build(mountain_id: params[:mountain_id], comments: params[:comments], hike_date: date)
        if @hike.save
          redirect("/hikes")
        else
          @error_messages << @hike.errors.full_messages.to_sentence
          erb :'hikes/new'
        end
      else
        @error_message = "* Please fill in all the form fields."
        erb :'hikes/new'
      end
    else
      redirect("/login")
    end
  end

  get "/hikes/:id" do
    if logged_in?
      @hiker = @current_user
      @hike = Hike.find_by(id: params[:id])
      if @hike # scenario where hikes id does not exist
        if @hiker.id == @hike.hiker_id
          erb :'hikes/show'
        else
          redirect("/hikes")
        end
      else
        redirect("/hikes")
      end
    else
      redirect("/login")
    end
  end

  get "/hikes/:id/edit" do
    if logged_in?
      @hiker = @current_user
      @hike = Hike.find_by(id: params[:id])
      if @hike # scenario where hikes id does not exist
        if @hiker.id == @hike.hiker_id
          hike_date = @hike.hike_date.to_s.split("-")
          @year = hike_date[0]
          @month = hike_date[1].to_i.to_s
          @day = hike_date[2].split(" ")[0].to_i.to_s
          erb :'hikes/edit'
        else
          redirect("/hikes")
        end
      else
        redirect("/hikes")
      end
    else
      redirect("/login")
    end
  end

  patch "/hikes/:id" do
    if logged_in?
      hiker = @current_user
      if form_filled_in?(params)
        @hike = Hike.find_by(id: params[:id])
        if @hiker.id == @hike.hiker_id
          date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
          @edited_hike = hiker.hikes.build(mountain_id: params[:mountain_id], comments: params[:comments], hike_date: date)
          if @edited_hike.update
            redirect("/hikes/#{params[:id]}")
          else
            @error_messages << @edited_hike.errors.full_messages.to_sentence
            erb :'hikes/new'
          end
        else
          redirect("/hikes")
        end
      else
        @error_message = "* Please fill in all the form fields."
        redirect("/hikes/#{params[:id]}/edit")
      end
    else
      redirect("/login")
    end
  end

  delete "/hikes/:id" do
    if logged_in?
      @hiker = @current_user
      @hike = Hike.find_by(id: params[:id])
      if @hiker.id == @hike.hiker_id
        @hike.delete
        redirect("/hikes")
      else
        redirect("/hikes")
      end
    else
      redirect("/login")
    end
  end
end