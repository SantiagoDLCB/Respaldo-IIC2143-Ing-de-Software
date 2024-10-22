# Clase que controla las solicitudes de participación en una iniciativa.
class RequestsController < ApplicationController
  before_action :authenticate_user!
  # Retorna todas las solicitudes de una iniciativa
  # @return [Request] todas las solicitudes
  def index
    @initiative = Initiative.find(params[:initiative_id])
    @all_requests = @initiative.requests
    @active_requests = @initiative.requests.where(status: :pending)
    @old_requests = @initiative.requests.where(status: [:accepted, :denied])
  end

  # Crea una nueva solicitud y redirige a la vista de la iniciativa
  def create
    @request = Request.new
    @request.user = current_user
    @request.status = params[:request][:status]
    @request.initiative = Initiative.find(params[:request][:initiative])
    if @request.save
      flash[:notice] = "Solicitud enviada correctamente."
      redirect_to initiative_path(params[:request][:initiative])
    else
      flash[:alert] = "Error al crear la solicitud."
      redirect_to initiative_path(params[:request][:initiative])
    end
  end

  # Actualiza una solicitud y redirige a la vista de la iniciativa
  def update
    @request = Request.find(params[:id])
    @request.status = request_params[:status]
    if @request.save
      flash[:notice] =  @request.status_before_type_cast
      if @request.status == "accepted" or @request.status == "denied"
        redirect_to initiative_path(@request.initiative)
      else
        redirect_to initiative_path(@request.initiative)
      end
    else
      flash[:alert] = "Error al actualizar la solicitud."
      redirect_to initiative_path(@request.initiative)
    end
  end

  private
  # Parametros permitidos para la creación de una solicitud
  def request_params
    params.require(:request).permit(:status, :initiative)
  end
end
