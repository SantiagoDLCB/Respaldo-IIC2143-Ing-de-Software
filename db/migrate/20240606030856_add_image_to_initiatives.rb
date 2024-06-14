class AddImageToInitiatives < ActiveRecord::Migration[7.1]
  def change
    add_column :initiatives, :image, :string
  end
end
