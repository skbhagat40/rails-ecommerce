class OrderLineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_one :seller, through: :product
end
