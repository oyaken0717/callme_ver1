class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 140}

  belongs_to :group
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
end
