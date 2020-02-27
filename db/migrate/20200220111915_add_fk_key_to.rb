class AddFkKeyTo < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :addresses, :users
  end
end
