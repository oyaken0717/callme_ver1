class Tag < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 50 }

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings, source: :post
end
