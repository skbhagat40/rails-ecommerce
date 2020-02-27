class Product < ApplicationRecord
  VERTICALS = {'MEN': 0, 'WOMEN': 1, 'ALL': 2}
  CATEGORIES = {'ELECTRONICS': 0, 'CLOTHING': 1, 'ACCESSORIES': 2, 'OTHER': 3}
  enum vertical: VERTICALS
  enum category: CATEGORIES
  belongs_to :seller
  has_many_attached :images, dependent: :destroy

  has_many :reviews, dependent: :destroy
  validates :seller, presence: true
  validates :name, :title, :description, :price, :stock, :vertical, :category, presence: true
  has_many :order_line_items
  has_many :orders, through: :order_line_items
end
