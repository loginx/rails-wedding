class RsvpsController < ApplicationController
  # GET /rsvps/1
  # GET /rsvps/1.xml
  def show
    @rsvp = Rsvp.includes(:guests).find_by_uuid!(params[:id])
    respond_with(@rsvp)
  end

  # GET /rsvps/new
  # GET /rsvps/new.xml
  def new
    @rsvp = Rsvp.new
    @rsvp.guests.build
    respond_with(@rsvp)
  end

  # POST /rsvps
  # POST /rsvps.xml
  def create
    @rsvp = Rsvp.new(rsvp_params)
    if @rsvp.save
      Notifications.delay.dispatch_rsvp(@rsvp)

      @rsvp.guests(true).each do |guest|
        Notifications.delay.confirm_rsvp(guest)
      end

    end
    respond_with(@rsvp)
  end

  # GET /rsvps/1/edit
  def edit
    @rsvp = Rsvp.includes(:guests).find_by_uuid!(params[:id])
    respond_with(@rsvp)
  end

  # PUT/PATCH /rsvps/1
  # PUT/PATCH /rsvps/1.xml
  def update
    @rsvp = Rsvp.find_by_uuid!(params[:id])
    @rsvp.update_attributes(rsvp_params)
    respond_with(@rsvp)
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:ip_address, :guests_attributes => [:attending, :diet, :email, :name]).merge(:ip_address => request.ip)
  end

end
