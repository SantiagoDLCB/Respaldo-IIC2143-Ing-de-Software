class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event= Event.new
  end

  def create
    @event= Event.new(new_event_params)
    if @event.save
      redirect_to event_path(@event.id), notice: 'Evento creado exitosamente.'
    else
      redirect_to event_path(@event.id), notice: 'Evento no ha podido ser creado.'
    end
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

  def edit
    @event = Event.find(params[:id])
    @initiative = @event.initiative
    @admins = @initiative.get_all_admins
    @attendants = @event.get_attendants
  end

  def update
    @event = Event.find(params[:id])

    @type = params[:event][:update_type]
    if @type == 'data'
      if @event.modify_capacity(params[:event][:capacity].to_i)
        if @event.update(event_params)
          redirect_to event_path(@event), notice: 'El evento fue actualizado exitosamente.'
        else
          render :edit
        end
      end
    elsif  @type  == 'remove_attendant'
      user = User.find(params['event'][:user_id])
      user.remove_role(:attendant, @event)
      if not user.has_role?(:attendant, @event)
        redirect_to event_path(@event), notice: 'Se ha quitado al usuario del evento.'
      else
        redirect_to event_path(@event), notice: 'No se ha podido quitar al usuario del evento.'
      end

    else
      redirect_to event_path(@event), alert: 'No se pudo realizar la acción solicitada.'

    end
  end

  def update_attendats
    @user = current_user
    @event = Event.find(params[:id])
    if @event.get_attendants.count < @event.capacity
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
  def new_event_params
    parametros = params.permit(:initiative, :name, :description, :capacity)
    parametros[:initiative] = Initiative.find(parametros[:initiative])
    parametros
  end
end
