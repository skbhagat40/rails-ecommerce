class AddSomeFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_seller, :boolean, :default => false
  end
end
