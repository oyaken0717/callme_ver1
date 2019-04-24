class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length:  { maximum: 30 }
  has_many :posts
  has_many :members, dependent: :destroy
  has_many :member_users, through: :members, source: :user
end
