# Clase que maneja la lógica de los anuncios de un evento.
class NoticesController < ApplicationController
  before_action :authenticate_user!

  # Retorna todos los anuncios de un evento
  # @return [Notice] todos los anuncios
  def index
    @event = Event.find(params[:event_id])
    @notice = @event.notice.order(created_at: :asc)
  end

  # Crea un nuevo anuncio y redirige a la vista del evento
  def create
    @notice = Notice.new(notice_params)
    @notice.event = Event.find(params[:event_id])

    if @notice.save
      redirect_to event_path(@notice.event), notice: 'Anuncio creado exitosamente.'
    else
      redirect_to event_path(@notice.event), alert: 'No se ha podido crear el anuncio. Intente nuevamente.'
    end
  end

  private
  # Parametros permitidos para la creación de un anuncio
  def notice_params
    params.permit(:title,:content, :event_id)
  end
  end
