class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def authorize_admin!
    if !user_signed_in? && !current_user.admin?
      redirect_to root_path, alert: "Path not found"
    end
  end
end
