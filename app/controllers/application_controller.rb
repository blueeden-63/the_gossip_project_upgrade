class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :user_signed_in?

  private

  def current_user
    return nil unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    return if user_signed_in?

    flash[:error] = "Vous devez vous connecter"
    redirect_to new_session_path
  end
end
