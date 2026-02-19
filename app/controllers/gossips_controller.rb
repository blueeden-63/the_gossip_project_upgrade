class GossipsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy]
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:new, :create, :edit, :update]
  before_action :authorize_gossip_owner!, only: [:edit, :update, :destroy]

  def index
    @gossips = Gossip.includes(:user, :comments, :likes).order(created_at: :desc)
    @liked_gossip_ids = if user_signed_in?
      current_user.likes.where(likable_type: "Gossip", likable_id: @gossips.map(&:id)).pluck(:likable_id)
    else
      []
    end
  end

  def show
    @comments = @gossip.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
    @liked_by_current_user = user_signed_in? && current_user.likes.exists?(likable: @gossip)
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user

    if @gossip.save
      flash[:success] = "Le potin a ete cree avec succes !"
      redirect_to gossips_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gossip.update(gossip_params)
      flash[:success] = "Le potin a ete mis a jour avec succes !"
      redirect_to gossip_path(@gossip)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip.destroy
    flash[:success] = "Le potin a ete supprime avec succes !"
    redirect_to gossips_path, status: :see_other
  end

  private

  def set_gossip
    @gossip = Gossip.includes(:user, :tags).find(params[:id])
  end

  def set_tags
    @tags = Tag.order(:title)
  end

  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
  end

  def authorize_gossip_owner!
    return if @gossip.user_id == current_user.id

    flash[:error] = "Action non autorisee"
    redirect_to gossip_path(@gossip)
  end
end
