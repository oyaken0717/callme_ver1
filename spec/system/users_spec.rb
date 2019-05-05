require 'rails_helper'

describe 'user管理機能', type: :system do
  let(:user_b) { FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com') }

  describe 'usr登録のテスト' do
   context 'ユーザーDがサイトを訪問し' do
     it 'アカウント登録する' do
      visit new_user_path
      fill_in "user_name", with: "d@d.com"
      fill_in "user_email", with: "d@d.com"
      fill_in "user_password", with: "d@d.com"
      fill_in "user_パスワード再確認", with: "d@d.com"
      click_on "登録"
      expect(page).to have_content 'd@d.comのページ'
     end
   end
  end

  describe 'usr登録のテスト' do
   context 'ユーザーDがサイトを訪問し' do
     it 'ログイン失敗する' do
      visit new_session_path
      fill_in "session_email", with: "d@d.com"
      fill_in "session_password", with: "d@d.com"
      click_button "ログイン"
      expect(page).to have_content 'ログイン失敗'
     end
   end
  end

  describe 'usr登録のテスト' do
   context 'ユーザーDがサイトを訪問し' do
     it 'ログアウトする' do
      visit new_user_path
      fill_in "user_name", with: "d@d.com"
      fill_in "user_email", with: "d@d.com"
      fill_in "user_password", with: "d@d.com"
      fill_in "user_パスワード再確認", with: "d@d.com"
      click_on "登録"
      expect(page).to have_content 'd@d.comのページ'
      click_link "ログアウト"
      expect(page).to have_content 'ログアウトしました'
     end
   end
 end

  describe 'usr登録のテスト' do
    context 'ユーザーBがサイトを訪問し' do
      let(:login_user) { user_b }

      before do
        visit new_session_path
        fill_in 'session_email', with: login_user.email
        fill_in 'session_password', with: login_user.password
        click_button 'ログイン'
      end

      it 'ログイン時にログインページに行かない' do
        visit new_session_path
        expect(page).to have_content "User一覧"
      end
    end
  end

  describe 'usr登録のテスト' do
   context 'ユーザーBがサイトを訪問し' do
     it 'ログアウト時にグループページに行かない' do
       visit groups_path
       expect(page).to have_content "メールアドレス"
     end
   end
  end
end
