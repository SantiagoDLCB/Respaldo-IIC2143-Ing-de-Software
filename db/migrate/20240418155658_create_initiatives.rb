class CreateInitiatives < ActiveRecord::Migration[7.1]
  def change
    create_table :initiatives do |t|
      t.string :name
      t.string :topic
      t.text   :description
      t.timestamps
    end
    add_index :initiatives, :name, unique: true
  end
end
