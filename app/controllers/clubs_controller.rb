class ClubsController < ApplicationController
  get "/clubs" do
    @clubs = Club.all

    erb :'clubs/clubs'
  end

  get "/clubs/:slug" do
    @club = Club.find_by_slug(params[:slug])

    erb :'clubs/show'
  end
end