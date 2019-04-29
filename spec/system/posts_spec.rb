require 'rails_helper'

describe 'グループの中の仕事管理機能', type: :system do
  let(:user_b) { FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com') }
  let(:user_c) { FactoryBot.create(:user, name: 'c@c.com', email: 'c@c.com', password: 'c@c.com') }
  let!(:post_b) { FactoryBot.create(:post, title: 'post2', user: user_b, group: group_b) }
  let!(:group_b) { FactoryBot.create(:group, name: 'group2') }

  before do
    visit new_session_path
    fill_in 'session_email', with: login_user.email
    fill_in 'session_password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'グループの中の仕事一覧表示機能' do
    context 'ユーザーBがログインし、グループ2に所属しているとき' do
      let (:login_user) { user_b }

      it 'ユーザーBが作成したタスクが表示される' do
        click_link("全グループ一覧画面")
        page.first(".group-item__body-link").click_link
        click_on '参加する'
        page.first(".group-item__body-link").click_link
        expect(page).to have_content 'グループ名: group2'
        click_on '仕事一覧'
        expect(page).to have_content 'post2'
      end
    end

    context 'ユーザー「C」がログインしている時' do
      let (:login_user) { user_c }

      it 'ユーザー『B』が作成したタスクが表示されない' do
        click_link '全グループ一覧画面'
        page.first(".group-item__body-link").click_link
        expect(page).to have_no_content 'post2'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      before do
        # group_b = FactoryBot.create(:group, name: 'group2')
        visit group_post_path(group_b, post_b)
      end

      it 'ユーザーBが作成した仕事が表示される' do
        expect(page).to have_content 'post2'
      end
    end
  end
end
