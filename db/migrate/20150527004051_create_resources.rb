class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :address
      t.text :notes
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
