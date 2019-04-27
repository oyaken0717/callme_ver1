class Comment < ApplicationRecord
  validates :created_at, date: true
  validates :updated_at, date: true
  belongs_to :user
  belongs_to :post
end
