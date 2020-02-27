class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
