class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) #affiche l'utilisateur de l'id correspondant
  end
end
