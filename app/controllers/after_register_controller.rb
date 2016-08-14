class AfterRegisterController < ApplicationController
  include Wicked::Wizard
  
  before_filter :authenticate_user!
  
  steps :add_birth, :add_others   #, :add_address
  
  def show
    #@user = current_user
    @account = current_user.account
    render_wizard
  end
  
  def update
    #@user = current_user
    @account = current_user.account
    @account.update_attributes(account_params)
    
    if wizard_path == after_register_path(:add_birth)
      check_or_update_registration
    else
      render_wizard(@account)
    end
    
  end
  
  
  private
    
    def check_or_update_registration
      if (@account.birth_name.blank? || @account.birth_date.blank? || @account.gender.blank? ||
        @account.birth_number.blank? || @account.birth_place.blank?)
      
        redirect_to after_register_path(:add_birth), :notice => "Zkontrolujte položky. Všechny musí být vyplněny."
      
      else
        
        @user.status = "registered"
        @user.save
        redirect_to root_path, :notice => "Děkujeme za registraci. Očekávejte emailové potvrzení, jakmile budete schváleni manažerem."
      end
    end
    
    def account_params
      params.require(:account).permit(:id, :user_id, :degree_before, :degree_after, :birth_name, :birth_date, :gender, 
                    :birth_place, :birth_number, :nationality, :family_status, :bank_acc, :insurance, :occupation, :terms, :status)
    end
    
end