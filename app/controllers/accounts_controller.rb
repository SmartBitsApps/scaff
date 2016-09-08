class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
  after_action :approve_registration, only: [:update, :edit]

  # GET /accounts
  # GET /accounts.json
  def index
    
    @accounts = Account.all.order(created_at: :desc)
    authorize @accounts
    #case current_user.role
    #  when "admin"
    #    @accounts = Account.all
    #    
    #  when "manager"
    #    @accounts = Account.all
    #  when "user"
    #    @user = current_user
    #    
    #    render "dashboard/user"  
    #  when "pending"
    #    @user = current_user
    #    render "dashboard/pending" 
    #  else
    #    redirect_to root_path, notice: "Přístup zamítnut."
    #end
    
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    authorize @account
  end

  # GET /accounts/new
  def new
    @account = Account.new
    authorize @account
  end

  # GET /accounts/1/edit
  def edit
    authorize @account
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    authorize @account
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
    
    authorize @account
    respond_to do |format|
      
      if @account.update(account_params)
        
        #if @account.status == :completed
        #  @account.user.update_attributes(role: :user)
        #end
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
    authorize @account
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Účet byl smazán.' }
      format.json { head :no_content }
    end
  end
  
  
  
  def approve_registration()
    #@user = current_user
    binding.pry
    @account = Account.find(params[:id])
    authorize @account
    #@user = @account.user
    
    #@user = User.find(id: @account.user_id)
    #@user = User.find(params[:user_id])
    
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    else
      @user = User.find_by(id: @account.user_id)
    end
    
    
      if @account.status == "completed" && @user.role == "pending"
        
        @user.update(role: :user)
        #@user.update_attributes(role: :user)
        flash[:notice] = "Uživatel #{@user.full_name} byl povýšen na roli: #{@user.role}"
        
      else
        flash[:notice] = "Někde se stala chyba."
        
      end
    redirect_to(dashboard_path)
    
  end
    
    
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
   # def set_account
   #   if current_user.role == "admin"
   #   
   #     @account = Account.find(params[:id])
   #   elsif current_user.role == "manager"
   #     @account = Account.find(params[:id])
   #   else
   #     @account = current_user.account
   #   end
   # end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(policy(@account).permitted_attributes)
    end
    
    
  
end
