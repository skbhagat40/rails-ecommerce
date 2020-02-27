class Address < ApplicationRecord
  ADDRESS_TYPES = [:home, :work, :other]
  enum address_type: ADDRESS_TYPES
  belongs_to :user

  validates :pin_code, presence: true, length: {minimum: 6, maximum: 6}
  validates :locality, :state, :country, :address_type, presence: true
end
