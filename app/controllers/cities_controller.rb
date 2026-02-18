class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = @city.gossips.order(created_at: :desc)
  end
end