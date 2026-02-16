class StaticPagesController < ApplicationController
  def home
    @gossips = Gossip.all.order(created_at: :desc) #affiche du plus recents au plus anciens
  end

  def team
  end

  def contact
  end

  def welcome
    @first_name = params[:first_name] #récupère le prénom de l'url et le stock dans une variable d'instance pour l'aficher dans vue 
  end
end
