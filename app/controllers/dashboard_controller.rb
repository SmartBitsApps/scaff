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
          #@user = current_user
          #users with role "pending"
#          @users = User.all.where(role: 0)
#          #accounts for users with role "pending"
#          @pending_accounts = Account.joins(:user).where(:accounts => { :user_id => @users.ids })
#          #accounts where status = "ended"
#          @registrations = @pending_accounts.all.where(status: 1)
          
          @registrations = Account.joins(:user).where(:accounts => { :user_id => User.all.where(role: 0)}).all.where(status: 1)
          @approved_accounts = Account.all.where(status: 2)
          @role_users = User.all.where(role: 1)
          render "dashboard/manager"
        when "user"
          @user = current_user
          @my_subscriptions = Subscription.joins(:user).where(:subscriptions => { :user_id => @user.id })
          render "dashboard/user"  
        when "pending"
          @user = current_user
          render "dashboard/pending" 
        else
          redirect_to root_path, notice: "Přístup zamítnut."
      end
   end
end
