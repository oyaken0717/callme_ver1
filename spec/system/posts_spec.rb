require 'rails_helper'

describe 'post管理機能', type: :system do
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

  shared_examples_for 'ユーザーBが作成したpostが表示される' do
    it { expect(page).to have_content 'post2' }
  end

  describe 'post一覧表示機能' do
    context 'ユーザーBがログインし、グループ2に所属しているとき' do
      let (:login_user) { user_b }

      it 'ユーザーBが作成したpostが表示される' do
        click_link("全グループ一覧画面")
        binding.pry
        page.first(".group-item__body-link").click_link
        click_on '参加する'
        page.first(".group-item__body-link").click_link
        expect(page).to have_content 'グループ名: group2'
        click_on '仕事一覧'
        visit group_posts_path(group_b)
        expect(page).to have_content 'post2'
      end
    end

    context 'ユーザー「C」がログインしている時' do
      let (:login_user) { user_c }

      it 'ユーザー『B』が作成したpostが表示されない' do
        click_link '全グループ一覧画面'
        page.first(".group-item__body-link").click_on
        expect(page).to have_no_content 'post2'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      before do
        visit group_post_path(group_b, post_b)
      end
      it_behaves_like 'ユーザーBが作成したpostが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_b }
    let(:post_titile) { post3 }

    before do
      visit new_group_post_path(group_b)
      fill_in 'post_title', with: post_title
      click_button '登録する'
    end

    context '新規作成画面で名称を入力した時' do
      let(:post_title) { 'post3' }

      it '正常に登録される' do
        expect(page).to have_content 'post3'
        click_button '登録する'
        expect(page).to have_selector '.post-index__notice', text: '作成ができました。'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:post_title) { '' }

      it 'エラーになる' do
        expect(page).to have_content 'Titleを入力してください'
      end
    end
  end

  describe 'post更新機能' do
    context 'ユーザーBがログインし、グループ2に所属しているとき' do
      let (:login_user) { user_b }

      before do
        visit edit_group_post_path(group_b, post_b)
      end

      it "更新する" do
        fill_in 'post_title', with: "post_4"
        click_button '更新する'
        expect(page).to have_content '編集しました'
      end

    end
  end

  describe '削除機能' do
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      before do
        visit group_post_path(group_b, post_b)
      end

      # it "削除する" do
      #   expect(page).to have_content '詳細'
      #   # click_link "削除"
      #   binding.pry
      #
      #   page.first(".post-show__delete").click_on
      #   # page.first(".post-show__delete").click_link
      #   expect(page).to have_content '本当に削除しますか？'
      #   # expect(page).to have_content '削除しました'
      # end

    end
  end
end
