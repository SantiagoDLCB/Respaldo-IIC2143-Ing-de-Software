class ReportsController < ApplicationController
  before_action :authenticate_user!
  def index
    @initiative = Initiative.find(params[:initiative_id])
    @reports = @initiative.reports.order(created_at: :asc)
  end
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

  def report_params
    params.require(:report).permit(:reason, :content, :user_id, :initiative_id)
  end
end
