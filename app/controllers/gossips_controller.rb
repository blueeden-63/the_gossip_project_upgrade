class GossipsController < ApplicationController
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:new, :create, :edit, :update]

  def index
    @gossips = Gossip.includes(:user, :comments).order(created_at: :desc)
  end

  def show
    @comments = @gossip.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @gossip = Gossip.new
  end

  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = User.find_by(first_name: "anonymous")

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
end
