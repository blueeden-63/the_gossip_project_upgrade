class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.new(comment_params)
    @comment.user = User.find_by(first_name: "anonymous")

    if @comment.save
      flash[:success] = "Commentaire ajoute avec succes"
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
    end

    redirect_to gossip_path(@gossip)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "Commentaire mis a jour avec succes"
      redirect_to gossip_path(@comment.commentable)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    gossip = @comment.commentable
    @comment.destroy
    flash[:success] = "Commentaire supprime avec succes"
    redirect_to gossip_path(gossip), status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end