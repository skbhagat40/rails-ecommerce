class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :company_name
      t.string :gst
      t.string :company_address

      t.timestamps
    end
  end
end
