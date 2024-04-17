class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string, null: false
    add_index :users, :username, unique: true
    add_column :users, :name, :string
    add_column :users, :last_name, :string
  end
end
