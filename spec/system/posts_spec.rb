require 'rails_helper'

describe '仕事管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_b = FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com')
      group_2 = FactoryBot.create(:group, name: 'group2')
      post_2 = FactoryBot.create(:post, title: 'post2', user: user_b, group: group_2)

    end

    context 'ユーザーBがログインし、グループ2に所属しているとき' do
      before do
        visit new_session_path
        fill_in 'session_email', with: 'b@b.com'
        fill_in 'session_password', with: 'b@b.com'
        click_button 'ログイン'

        click_on '全グループ一覧画面'
        page.first(".group-item__body-link").click_link
        click_on '参加する'
        page.first(".group-item__body-link").click_link
        expect(page).to have_content 'グループ名: group2'
      end

      it 'ユーザーBが作成したタスクが表示される' do
        click_on '仕事一覧'
        expect(page).to have_content 'post2'
      end
    end
  end
end
