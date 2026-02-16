class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id]) #affiche le potin de l'id correspondant dans l'url
  end
end
