class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  
   def index
      case current_user.status
        when "banned"
          redirect_to root_path, notice: "Přístup zamítnut." and return
      end
      
      case current_user.role
        when "admin"
          @user = current_user
          @users_total = User.all.size
          render "dashboard/admin"
        when "manager"
          @user = current_user
          render "dashboard/manager"
        when "user"
          @user = current_user
          
          render "dashboard/user"  
        when "pending"
          @user = current_user
          render "dashboard/pending" 
        else
          redirect_to root_path, notice: "Přístup zamítnut."
      end
   end
end
