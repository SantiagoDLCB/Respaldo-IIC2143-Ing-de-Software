# Clase que representa un controlador de reportes de la aplicación. Esta maneja la lógica de los reportes.
class ReportsController < ApplicationController
  before_action :authenticate_user!
  # Retorna todos los reportes de una iniciativa
  # @return [Report] todos los reportes
  def index
    @initiative = Initiative.find(params[:initiative_id])
    @reports = @initiative.reports.order(created_at: :asc)
  end

  # Crea un nuevo reporte y redirige a la vista de la iniciativa
  def create
    @report = Report.new(report_params)
    @report.user = current_user
    @report.initiative = Initiative.find(params[:initiative_id])

    if @report.save
      redirect_to initiative_path(@report.initiative), notice: 'Reporte creado exitosamente.'
    else
      redirect_to initiative_path(@report.initiative), alert: 'Error al crear reporte.'
    end
  end

  private
  # Parametros permitidos para la creación de un reporte
  def report_params
    params.require(:report).permit(:reason, :content, :user_id, :initiative_id)
  end
end
