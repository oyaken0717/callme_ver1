require 'rails_helper'

describe 'post管理機能', type: :system do
  let(:user_b) { FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com') }
  let(:user_c) { FactoryBot.create(:user, name: 'c@c.com', email: 'c@c.com', password: 'c@c.com') }
  let!(:post_b) { FactoryBot.create(:post, title: 'post2', user: user_b, group: group_b) }
  let!(:tag_b) { FactoryBot.create(:tag, name: 'tag2') }
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
        expect(page).to have_content 'ログインしました'
        click_on "グループ一覧"
        expect(page).to have_content 'グループ作成'
        click_on"group2"
        click_on '参加する'

        click_on"group2"
        expect(page).to have_content 'グループ名: group2'
        click_on '仕事一覧'
        expect(page).to have_content 'post2'
      end
    end

    context 'ユーザー「C」がログインしている時' do
      let (:login_user) { user_c }

      it 'ユーザー『B』が作成したpostが表示されない' do
        click_on 'グループ一覧'
        expect(page).to have_content 'group2'
        click_link 'group2'
        expect(page).to have_no_content 'post2'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      before do
        expect(page).to have_content 'ログインしました'
        click_on "グループ一覧"
        click_on"group2"
        click_on '参加する'
        click_on"group2"
        click_on '仕事一覧'
        expect(page).to have_content 'post2'
      end

      it "postの詳細が見られる" do
        click_link "post2"
        expect(page).to have_content '投稿者'
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_b }
    let(:post_title) { post3 }

    context '新規作成画面で名称を入力した時' do
      before do
        expect(page).to have_content 'ログインしました'
        click_on "グループ一覧"
        click_link"group2"
        click_on '参加する'
        click_link"group2"
      end

      it '正常に登録される' do
        click_link"仕事一覧"
        expect(page).to have_content 'タグ'
        click_link"新規作成"
        fill_in 'post_title', with: 'post3'
        click_button '登録する'
        expect(page).to have_content 'post3'
        click_button '登録する'
        expect(page).to have_content '作成ができました。'
      end

      it 'タグ付きも正常に登録される' do
        click_link"仕事一覧"
        expect(page).to have_content 'タグ'
        click_link"新規作成"
        fill_in 'post_title', with: 'post3'
        # check "task_label_ids_1"
        #なんでもいいから 存在するtagのid１つ
        # 全てのtag、配列に入った中から1つ
        target_id = Tag.first.id
        check "post_tag_ids_#{target_id}"
        click_button '登録する'
        expect(page).to have_content 'post3'
        click_button '登録する'
        expect(page).to have_content '作成ができました。'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      before do
        expect(page).to have_content 'ログインしました'
        click_on "グループ一覧"
        click_link"group2"
        click_on '参加する'
        click_link"group2"
      end

      it 'エラーになる' do
        click_link"仕事一覧"
        click_link"新規作成"
        fill_in 'post_title', with: ''
        click_button '登録する'
        expect(page).to have_content 'Titleを入力してください'
      end
    end
  end

  describe 'post更新機能' do
    context 'ユーザーBがログインし、グループ2に所属しているとき' do
      let (:login_user) { user_b }

      before do
        click_on "グループ一覧"
        click_link"group2"
        click_on '参加する'
        click_link"group2"
      end

      it "更新する" do
        click_link"仕事一覧"
        click_link"post2"
        click_link"編集"
        fill_in 'post_title', with: "post4"
        click_button '更新する'
        expect(page).to have_content '編集しました'
      end
    end
  end

  describe '削除機能' do
    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      before do
        click_on "グループ一覧"
        click_link"group2"
        click_on '参加する'
        click_link"group2"
      end

      it "削除する" do
        click_link"仕事一覧"
        click_link"post2"
        click_link"削除"
      end
    end
  end
end
