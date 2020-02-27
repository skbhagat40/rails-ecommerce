class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.integer :ratings
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
