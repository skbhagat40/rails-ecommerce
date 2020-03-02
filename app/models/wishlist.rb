class Wishlist < ApplicationRecord
  belongs_to :user
  # TODO use a join table to handle multiple products in a wishlist, instead of creating multiple wishilists to store multiple products
  belongs_to :product
end
