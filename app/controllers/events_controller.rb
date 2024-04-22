class EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @initiative = Initiative.find(params[:initiative])
    @event= Event.new
  end

  def create
    @event = Event.new(params[:initiative])
    if @event.save
      current_user.add_role :admin_event, @event
      redirect_to iniciative_path(@initiative.id) , notice: 'Event was successfully created.'
    else
      error1 = "No se ha podido crear el evento, por favor revise que los datos esten bien ingresados."
      redirect_to root_path, notice: error1
    end
  end
  def event_params
    params.require(:event).permit(:initiative, :name, :description, :capacity)
  end
end
