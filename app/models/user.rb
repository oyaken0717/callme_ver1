class User < ApplicationRecord
  before_validation { email.downcase! }

  validates :name, presence: true, length:  { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  mount_uploader :image, ImageUploader

  has_many :members, dependent: :destroy
  has_many :groups, through: :members, source: :group
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy
  # has_many :member_groups, through: :members, source: :group




end
