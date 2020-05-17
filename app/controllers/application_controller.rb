class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  	user = current_user.id
    user_path(user) 
  end

  def after_sign_up_path_for(resource)
  	user = current_user.id
    user_path(user) 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |n| n.permit(:name,:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |n| n.permit(:name,:email, :password, :password_confirmation) }
  end
end
