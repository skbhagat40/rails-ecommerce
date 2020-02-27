class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.belongs_to :seller, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.string :description
      t.integer :price
      t.integer :stock
      t.integer :vertical
      t.integer :category
      t.integer :discount

      t.timestamps
    end
  end
end
