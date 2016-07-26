class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:new, :create, :show]
  before_action :set_managers, only: [:edit, :update, :new, :create]
  before_action :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all #.where(visible: true)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    #@comments = Comment.joins(:post).where(:posts => { :user_id => @user.id })
    @brigades = Brigade.joins(:event).where(:brigades => { :event_id => @event.id })
    #@brigades = Brigades.find_by(event_id: @event)
  end

  # GET /events/new
  def new
    
    @event = @user.events.new
    @event.event_addresses.build
    
  end

  # GET /events/1/edit
  def edit
    @event.event_addresses.build
  end

  # POST /events
  # POST /events.json
  def create
    #binding.pry
    @event = @user.events.build(event_params)
    

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    #binding.pry
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
    
    def set_current_user
      @user = current_user
    end
    
    def set_managers
      @managers = User.all.where(role: 2)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :title, :description, :start_date, :end_date, :manager, :visible,
                                    event_addresses_attributes: [:id, :event_id, :street, :street_number, :city])
    end
end
