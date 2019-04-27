class Group < ApplicationRecord
  validates :name, presence: true, length:  { maximum: 30 }, uniqueness: true
  has_many :posts, inverse_of: :group
  has_many :members, dependent: :destroy
  has_many :users, through: :members, source: :user
end
