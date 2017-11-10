class HikersController < ApplicationController
  

  get "/hikers/:id" do
    @hiker = Hiker.find(session[:hiker_id])
    erb :'hikers/show'
  end
end