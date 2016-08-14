class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /accounts
  # GET /accounts.json
  def index
    case current_user.role
      when "admin"
        @accounts = Account.all
        
      when "manager"
        @accounts = Account.all
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

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Účet byl úšpěšně vytvořen.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Účet byl úšpěšně upraven.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Účet byl smazán.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      if current_user.role == "admin"
      
        @account = Account.find(params[:id])
      elsif current_user.role == "manager"
        @account = Account.find(params[:id])
      else
        @account = current_user.account
      end
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :degree_before, :degree_after, :birth_name,
                              :birth_date, :gender, :birth_place, :birth_number, :nationality,
                              :family_status, :bank_acc, :insurance, :occupation, :terms, :status)
    end
end
