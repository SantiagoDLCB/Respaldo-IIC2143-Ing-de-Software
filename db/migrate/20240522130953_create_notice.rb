class CreateNotice < ActiveRecord::Migration[7.1]
  def change
    create_table :notices do |t|
      t.references :event, null: false, foreign_key: true
      t.text :title
      t.text :content
      t.timestamps
    end
  end
end
