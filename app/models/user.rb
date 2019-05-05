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
  # is_authorがgroupのshowから呼ばれる
  # group_idには@group.idからきた数が入る
    return false if self&.members.length == 0
    # if 「user」のメンバーの数が0であれば（メンバー登録が1つもない）、falseを返す（返り値）
    # 「user」は（インスタンスのuserなので）この場合current_user(User.find_by(id: session[:user_id]))を指す
    current_member = self.members.select { |member| member&.group_id == group_id }[0]
    #current_userが登録しているmembersをmemberで1行ずつにする
    #selectを使って{ }の中の「条件」に合致した要素だけを新しい配列に入れる
    #「条件」
    #一致したモデルの1行のデータを配列に入れる
    #(今回の場合１つしか入らない又は0)
    #(というか中間テーブルは該当複数っていうのはまずないんじゃないかなぁ…図にするとわかる)
    #配列にした1個目([0])の情報をcurrent_memberに入れる
    return current_member&.user_is_author
    #return にcurrent_memberのuser_is_authorのカラムの情報を返り値として入れとく
    #viewで使う時にifと組み合わせて
    #true→表示
    #false→何もしないにする
  end

  def is_member(group_id)
    return false if self&.members.length == 0
    join_member = self.members.select { |member| member&.group_id == group_id }[0]
    return true unless join_member.nil?
  end
end
