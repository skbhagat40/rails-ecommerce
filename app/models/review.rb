class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :ratings, presence: true
  validates :description, presence: true, length: {minimum: 10}
end
