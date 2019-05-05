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

  context 'ユーザー「C」がログインしている時' do
    let (:login_user) { user_c }

    it 'ユーザー『B』が作成したpostが表示されない' do

save_and_open_page
