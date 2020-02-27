class User < ApplicationRecord
  before_save {self.email = self.email.downcase}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # resources :users
  validates :name, presence: true , length: {minimum: 2, maximum: 20}
  # validates :is_seller, presence: true

  has_many :address, dependent: :destroy
  has_one :seller, dependent: :destroy
  has_many :wishlist, dependent: :destroy
  has_many :reviews, dependent: :nullify
  has_many :orders, dependent: :destroy
  # has_many :reviews, dependent: :nullify
end