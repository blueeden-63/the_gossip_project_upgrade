class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email]&.strip&.downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Connexion reussie"
      redirect_to root_path
    else
      flash.now[:error] = "Email ou mot de passe invalide"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    flash[:success] = "Deconnexion reussie"
    redirect_to root_path, status: :see_other
  end
end
