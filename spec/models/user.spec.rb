require 'rails_helper'
require 'pry'

RSpec.describe User, type: :model do

  let!(:user_e) { FactoryBot.create(:user, name: 'e@e.com', email: 'e@e.com', password: 'e@e.com') }
  # let!(:group_5) { FactoryBot.create(:group, name: 'group5') }
  # let!(:member_5) { FactoryBot.create(:member, user_is_author: true, group_id: group_5.id, user_id: user_e.id) }

  it "nameが空ならバリデーションが通らない" do
    user = User.new(name: '', email: "f@f.com", password: "f@f.com" )
    expect(user).not_to be_valid
  end

  it "nameとemailとpasswordに内容が記載されていればバリデーションが通る" do
    user = User.new(name: "f@f.com", email: "f@f.com", password: "f@f.com" )
    expect(user).to be_valid
  end

  it "User検索" do
    User.create(name: "g@g.com", email: "g@g.com", password: "g@g.com")
    User.create(name: "h@h.com", email: "h@h.com", password: "h@h.com")
    expect(User.search_name("g@g.com")).to eq User.where("name LIKE ?", "%#{"g@g.com"}%")
    expect(User.search_name("g@g.com").count) == 1
  end
end
