class RequestsController < ApplicationController
  def create
    @request = Request.new
    @request.user = current_user
    @request.status = params[:request][:status]
    @request.initiative = Initiative.find(params[:request][:initiative])
    if @request.save
      flash[:notice] = "Solicitud creada exitosamente"
      redirect_to initiative_path(params[:request][:initiative])
    else
      flash[:alert] = "Error al crear la solicitud"
      redirect_to initiative_path(params[:request][:initiative])
    end
  end

  def update
    @request = Request.find(params[:id])
    @request.status = request_params[:status]
    if @request.save
      flash[:notice] = "Solicitud actualizada exitosamente"
      redirect_to initiative_path(@request.initiative)
    else
      flash[:alert] = "Error al actualizar la solicitud"
      redirect_to initiative_path(@request.initiative)
    end
  end

  private

  def request_params
    params.require(:request).permit(:status, :initiative)
  end
end
