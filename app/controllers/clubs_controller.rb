class ClubsController < ApplicationController
  get "/clubs" do
    @clubs = Club.all

    erb :'clubs/clubs'
  end
end