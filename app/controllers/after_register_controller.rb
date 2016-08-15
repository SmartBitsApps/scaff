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
    
    if wizard_path == after_register_path(:add_others)
      check_or_update_registration
    else
      render_wizard(@account)
    end
    
  end
  
  
  private
    
    def check_or_update_registration
      if (@account.birth_name.blank? || @account.birth_date.blank? || @account.gender.blank? ||
        @account.birth_place.blank? || @account.birth_number.blank? || @account.nationality.blank? ||
        @account.family_status.blank? || @account.bank_acc.blank? || @account.insurance.blank? ||
        @account.occupation.blank? || @account.terms.blank?)
      
        redirect_to after_register_path(:add_birth), :notice => "Zkontrolujte položky. Všechny musí být vyplněny."
      
      else
        
        @account.status = "ended"
        @account.save
        redirect_to root_path, :notice => "Děkujeme za registraci. Očekávejte emailové potvrzení, jakmile budete schváleni manažerem."
      end
    end
    
    def account_params
      params.require(:account).permit(:user_id, :degree_before, :degree_after, :birth_name, :birth_date, :gender, 
                    :birth_place, :birth_number, :nationality, :family_status, :bank_acc, :insurance, :occupation, :terms, :status)
    end
    
end