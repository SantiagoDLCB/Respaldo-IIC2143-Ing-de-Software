# Clase que maneja la lógica de los eventos.
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_is_admin?, only: [:destroy, :update]

  # Crea un nuevo evento
  # @return [Event] el evento creado
  def new
    @event= Event.new
  end

  # Crea un nuevo evento y redirige a la vista de eventos
  def create
    @event= Event.new(new_event_params)
    if @event.save
      redirect_to event_path(@event.id), notice: 'Evento creado exitosamente.'
    else
      redirect_to root_path, notice: 'Evento no ha podido ser creado.'
    end
  end

  # Retorna todos los eventos
  # @return [Event] todos los eventos
  def index
    @admin_events = Event.joins(:initiative).where(initiatives: { id: current_user.roles.where(name: :admin_initiative).pluck(:resource_id) })
    @attendant_events = current_user.events.joins(:roles).where(roles: { name: :attendant }).distinct
    @other_events = Event.where.not(id: @admin_events.pluck(:id) + @attendant_events.pluck(:id))
  end
  
  # Retorna un evento determinado
  # @return [Event] el evento
  def show
    @event = Event.find(params[:id])
    @review = Review.new
    @initiative = @event.initiative
    @attendants = @event.get_attendants
    @reviews = @event.reviews.order(created_at: :desc)
    @notices = @event.notices.order(created_at: :desc)
  end

  # Elimina un evento y redirige a la vista de la iniciativa
  def destroy
    @event = Event.find(params[:id])
    @initiative = @event.initiative
    @event.destroy
    redirect_to initiative_path(@initiative), notice: 'El evento fue eliminado.'
  end

  # Actualiza un evento y redirige a la vista del evento
  def update
    @event = Event.find(params[:id])
    @type = params[:event][:update_type]


    if @type == 'data'

      if @event.modify_capacity(params[:event][:capacity].to_i)
        if @event.update(event_params)
          redirect_to event_path(@event), notice: 'El evento fue actualizado exitosamente.'

        else
          redirect_to event_path(@event), alert: 'Error: Intente nuevamente.'
        end
      else
        redirect_to event_path(@event), alert: 'No se pudo realizar la acción solicitada.'
      end
    elsif  @type  == 'remove_attendant'
      user = User.find(params['event'][:user_id])
      user.remove_role(:attendant, @event)
      if not user.has_role?(:attendant, @event)
        redirect_to event_path(@event), notice: 'Se ha quitado al usuario del evento.'
      else
        redirect_to event_path(@event), alert: 'No se ha podido quitar al usuario del evento.'
      end

    else
      redirect_to event_path(@event), alert: 'No se pudo realizar la acción solicitada.'

    end
  end

  # Actualiza los asistentes de un evento y redirige a la vista del evento
  def update_attendats
    @user = current_user
    @event = Event.find(params[:id])
    if @event.get_attendants.count < @event.capacity
      @user.add_role(:attendant, @event)
      redirect_to event_path(@event), notice: 'Te has inscrito al evento.'
    else
      redirect_to event_path(@event), alert: 'No hay capacidad disponible para unirse a este evento.'
    end
  end

  # Elimina un asistente de un evento y redirige a la vista del evento
  def leave
    @event = Event.find(params[:id])
    current_user.remove_role(:attendant, @event)
    redirect_to event_path(@event), notice: 'Te has salido del evento.'
  end

  private
  # Retorna true si el usuario es administrador de la iniciativa, false en caso contrario
  def current_user_is_admin?()
    @event = Event.find(params[:id])
    @initiative = @event.initiative
    check =current_user.has_role? :admin_initiative, @initiative
    if !check
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  # Retorna los parametros del evento
  def event_params
    parametros= params.require(:event).permit(:initiative, :name, :description, :capacity)
    parametros[:initiative] = Initiative.find(parametros[:initiative])
    parametros
  end

  # Retorna los parametros del nuevo evento
  def new_event_params
    parametros= params.permit(:initiative, :name, :description, :capacity)
    parametros[:initiative] = Initiative.find(parametros[:initiative])
    parametros
  end

end
