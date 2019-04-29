require 'rails_helper'

describe '仕事管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_b = FactoryBot.create(:user, name: 'b@b.com', email: 'b@b.com', password: 'b@b.com')
      FactoryBot.create(:post, name: 'post2', user: user_b)
    end

    context '' do
      before do

      end
    end

    it '' do

    end
  end
end
