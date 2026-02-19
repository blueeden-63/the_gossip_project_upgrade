class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) #affiche l'utilisateur de l'id correspondant
  end

  def new 
    @user = User.new
  end

  def create
    city = find_or_create_city
    @user = User.new(user_params)
    @user.city = city if city

    unless city
      @user.errors.add(:city, "Nom et code postal obligatoires")
      render :new, status: :unprocessable_entity
      return
    end

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Inscription reussie"
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :password, :password_confirmation)
  end

  def find_or_create_city
    city_name = params.dig(:user, :city_name).to_s.strip
    city_zip_code = params.dig(:user, :city_zip_code).to_s.strip

    return nil if city_name.blank? || city_zip_code.blank?

    City.find_or_create_by(name: city_name, zip_code: city_zip_code)
  end
end
