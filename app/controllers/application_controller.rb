class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize_admin!
    if !user_signed_in? && !current_user.admin?
      # raise ActionController::RoutingError.new("Not Found")
      redirect_to root_path, alert: "Path not found"
    end
  end
end
