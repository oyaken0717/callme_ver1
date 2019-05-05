require 'rails_helper'
require 'pry'

RSpec.describe Post, type: :model do

  let!(:user_e) { FactoryBot.create(:user, name: 'e@e.com', email: 'e@e.com', password: 'e@e.com') }
  let!(:group_5) { FactoryBot.create(:group, name: 'group5') }
  let!(:member_5) { FactoryBot.create(:member, user_is_author: true, group_id: group_5.id, user_id: user_e.id) }

  it "titleが空ならバリデーションが通らない" do
    post = Post.new(title: '')
    expect(post).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    post = Post.new(title: 'post1', content: 'post1', user_id: user_e.id, group_id: group_5.id)
    expect(post).to be_valid
  end

  it "title検索" do
    Post.create(title: "post6")
    Post.create(title: "post7")
    expect(Post.search_title("post6")).to eq Post.where("title LIKE ?", "%#{"post6"}%")
    expect(Post.search_title("post6").count) == 1
  end
end
