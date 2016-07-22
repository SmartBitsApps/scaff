class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def create
    super
  end
 
  protected
	  
	  def after_sign_in_path_for(resource)
	    super #dashboard_path
	  end
    
    def after_sign_out_path_for(resource)
	    super #root_path
    end
	  
    def after_sign_up_path_for(resource)
      super #after_register_path(:add_name)
    end
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me, :first_name, :last_name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :role, :status])
    end
  
  
  
end
