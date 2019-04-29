require 'rails_helper'

describe '仕事管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_b = FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com')
      FactoryBot.create(:post, title: 'post2', user: user_b)
      FactoryBot.create(:group, name: 'group2')
    end

    context 'ユーザーBがログインしている時' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'b@b.com'
        fill_in 'パスワード', with: 'b@b.com'
        click_button 'ログイン'
      end
    end

    it 'ユーザーBが作成したタスクが表示される' do
      expect(page).to have_content 'post2'
    end
  end
end
