require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
    describe 'ログイン機能' do
        before do
            #ユーザーを作成しておく
            user_a = FactoryBot.create(:user)
        end
        
        context 'ユーザーがログインしていない時' do
            before do
                #ログイン試行する？
                #URLにアクセスする
                visit login_path 
                #メールアドレスを入力する
                fill_in 'メールアドレス', with: 'test@example.com'
                #パスワードを入力する
                fill_in 'パスワード', with: 'password'
                #1ログインするボタンを押す
                click_button 'ログインする'
            end

            it 'ユーザーのマイページへ遷移する' do
                #ログアウトが表示されているか確認
                expect(page).to have_content 'ログアウト'
            end
        end
    end
end