class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = @city.gossips.includes(:user, :likes).order(created_at: :desc)
    @liked_gossip_ids = if user_signed_in?
      current_user.likes.where(likable_type: "Gossip", likable_id: @gossips.map(&:id)).pluck(:likable_id)
    else
      []
    end
  end
end