class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  
  def create
    super
  end
  
  protected
  
  def after_sign_up_path_for(resource)
    after_register_path(:add_birth)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :first_name, :last_name, :status, :password, :password_confirmation])
  end
end 