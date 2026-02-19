class LikesController < ApplicationController
  before_action :require_login
  before_action :set_gossip

  def create
    current_user.likes.find_or_create_by(likable: @gossip)
    redirect_back fallback_location: gossip_path(@gossip)
  end

  def destroy
    like = current_user.likes.find_by(likable: @gossip)
    like&.destroy
    redirect_back fallback_location: gossip_path(@gossip), status: :see_other
  end

  private

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end