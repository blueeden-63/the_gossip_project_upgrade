class GossipsController < ApplicationController
  def index
    @gossips = Gossip.all.order(created_at: :desc)
  end

  def show
    @gossip = Gossip.find(params[:id])
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

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
