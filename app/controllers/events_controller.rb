class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_initiative, only: [:new, :create]
  def new
    @event = @initiative.events.build
  end

  def create
    @event = @initiative.events.build(event_params)
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
    @review = Review.new
    @initiative = @event.initiative
    @attendants = @event.get_attendants
    @reviews = @event.reviews
  end

  def destroy
    @event = Event.find(params[:id])
    @initiative = @event.initiative
    @event.destroy
    redirect_to initiative_path(@initiative), notice: 'El evento fue eliminado.'
  end

  def update
    @event = Event.find(params[:id])
    @user = current_user

    if @event.users.count < @event.capacity
      @user.add_role(:attendant, @event)
      redirect_to event_path(@event), notice: 'Te has inscrito al evento.'
    else
      redirect_to event_path(@event), notice: 'No hay capacidad disponible para unirse a este evento.'
    end
  end

  def leave
    @event = Event.find(params[:id])
    current_user.remove_role(:attendant, @event)
    redirect_to event_path(@event), notice: 'Te has salido del evento.'
  end

  def event_params
    params.require(:event).permit(:initiative, :name, :description, :capacity)
  end
end
