class Seller < ApplicationRecord
  belongs_to :user
  has_many :product, dependent: :destroy
  has_many :order_line_items, through: :product
end
