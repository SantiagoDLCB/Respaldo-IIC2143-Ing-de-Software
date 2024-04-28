class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.references :initiative, null: false, foreign_key: true
      t.integer :capacity

      t.timestamps
    end
  end
end
