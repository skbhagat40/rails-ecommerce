class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.bigint :pin_code
      t.string :state
      t.string :country
      t.string :locality
      t.integer :address_type

      t.timestamps
    end
  end
end
