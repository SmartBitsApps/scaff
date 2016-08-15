class AccountPolicy < ApplicationPolicy
  #class Scope < Scope
  #  def resolve
  #    scope
  #  end
  #end
  
  def initialize(user, account)
    raise Pundit::NotAuthorizedError, "musíte být přihlášeni" unless user
    @user = user
    @account = account
  end
  
  def index?
    @user.admin? || @user.manager? || @user.account == @account
  end
  
  def show?
    @user.admin? || @user.manager? || @user.account == @account
  end
  
  def edit?
    @user.admin? || @user.manager? || @user.account == @account
  end
  
  def update?
    edit?
  end
  
  # TODO: solve deletion problem (who can delete account?)
  def destroy?
    return false if @user.account == @account
    @current_user.admin?
  end
  
  def permitted_attributes
    
    if user.admin? || user.manager? || user.account.id == @account.id
      [:user_id, :degree_before, :degree_after, :birth_name,
      :birth_date, :gender, :birth_place, :birth_number, :nationality,
      :family_status, :bank_acc, :insurance, :occupation, :terms, :status]
    else
      []
    end
  end
  
end
