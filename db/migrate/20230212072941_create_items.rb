class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.references :genre, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false

      t.timestamps null: false
    end
  end
end
