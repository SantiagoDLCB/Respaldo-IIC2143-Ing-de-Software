class AddStatusToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :status, :string, default: 'Pendiente'

    # Para actualizar los registros existentes
    reversible do |dir|
      dir.up { Report.update_all(status: 'Pendiente') }
    end
  end
end
