class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_initiative, only: [:new, :create]
  def new
    @event = @initiative.events.build
  end

  def create
    @event = @initiative.events.build(event_params)
    current_user.add_role :admin_event, @event
    if @event.save
      redirect_to initiative_path(@initiative.id), notice: 'Evento creado exitosamente.'
    else
      redirect_to initiative_path(@initiative.id), notice: 'Evento no ha podido ser creado.'
    end
  end
  def set_initiative
    @initiative = Initiative.find(params[:initiative_id])
  end
  def show
    @event = Event.find(params[:id])
    @initiative = @event.initiative
  end
  def destroy
    @event = Event.find(params[:id])
    @initiative = @event.initiative
    @event.destroy
    redirect_to initiative_path(@initiative), notice: 'El evento fue eliminado.'
  end

  def event_params
    params.require(:event).permit(:initiative, :name, :description, :capacity)
  end
end
