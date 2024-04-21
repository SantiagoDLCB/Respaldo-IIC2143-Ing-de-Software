class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :initiative, null: false, foreign_key: true
      t.string :status, null: false, default: 'Pendiente'
      t.timestamps
    end
  end
end
