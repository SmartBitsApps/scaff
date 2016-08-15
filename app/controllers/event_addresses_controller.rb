class EventAddressesController < ApplicationController
  before_action :set_event_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /event_addresses
  # GET /event_addresses.json
  def index
    @event_addresses = EventAddress.all.order(created_at: :desc)
  end

  # GET /event_addresses/1
  # GET /event_addresses/1.json
  def show
  end

  # GET /event_addresses/new
  def new
    @event_address = EventAddress.new
  end

  # GET /event_addresses/1/edit
  def edit
  end

  # POST /event_addresses
  # POST /event_addresses.json
  def create
    @event_address = EventAddress.new(event_address_params)

    respond_to do |format|
      if @event_address.save
        format.html { redirect_to @event_address, notice: 'Event address was successfully created.' }
        format.json { render :show, status: :created, location: @event_address }
      else
        format.html { render :new }
        format.json { render json: @event_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_addresses/1
  # PATCH/PUT /event_addresses/1.json
  def update
    respond_to do |format|
      if @event_address.update(event_address_params)
        format.html { redirect_to @event_address, notice: 'Event address was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_address }
      else
        format.html { render :edit }
        format.json { render json: @event_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_addresses/1
  # DELETE /event_addresses/1.json
  def destroy
    @event_address.destroy
    respond_to do |format|
      format.html { redirect_to event_addresses_url, notice: 'Event address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_address
      @event_address = EventAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_address_params
      params.require(:event_address).permit(:event_id, :street, :street_number, :city)
    end
end
