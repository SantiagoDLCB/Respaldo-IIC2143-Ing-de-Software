class EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @initiative = Initiative.new
  end

  def create
    @initiative = Initiative.new(event_params)
    if @initiative.save
      current_user.add_role :admin_event, @initiative
      redirect_to initiative_path(@initiative.id) , notice: 'Event was successfully created.'
    else
      error1 = "No se ha podido crear el evento, por favor revise que los datos esten bien ingresados."
      redirect_to root_path, notice: error1
    end
  end
end
