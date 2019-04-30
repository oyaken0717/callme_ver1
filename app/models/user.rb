class User < ApplicationRecord
  before_validation { email.downcase! }

  validates :name, presence: true, length:  { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  mount_uploader :image, ImageUploader

  has_many :members, dependent: :destroy
  has_many :groups, through: :members, source: :group
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy

  scope :search_name, -> (user_name) { where("name LIKE ?", "%#{ user_name }%") }

  def is_author(group_id)
    return false if self&.members.length == 0
    current_member = self.members.select { |member| member&.group_id == group_id }[0]
    return current_member&.user_is_author
  end

  def is_member(current_user)
    return false if self&.members.length == 0
    join_member = self.members.select { |member| member&.user_id == current_user.id }[0]
    return join_member
  end
end
