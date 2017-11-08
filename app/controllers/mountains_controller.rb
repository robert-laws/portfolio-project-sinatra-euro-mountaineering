class MountainsController < ApplicationController
  get "/mountains" do
    @mountains = Mountain.all

    erb :'mountains/mountains'
  end

  get "/mountains/:slug" do
    @mountain = Mountain.find_by_slug(params[:slug])

    erb :'mountains/show'
  end
end