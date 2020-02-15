require 'rails_helper'

describe 'セッション管理機能', type: :system do
    let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    #beforeの共通化
    shared_context 'ユーザーがログインする' do 
        before do
            visit login_path                                   #URLにアクセスする
            fill_in "Eメール", with: login_user.email           #Eメールを入力する
            fill_in 'パスワード', with: login_user.password     #パスワードを入力する
            click_button 'ログイン'                             #ログインするボタンを押す
        end
    end
    #itの共通化
    shared_examples_for 'ログアウトボタンが表示されている' do
        it { expect(page).to have_content 'ログアウト'}             #ログアウトが表示されているか確認
    end

    before do
        user_a = FactoryBot.create(:user)                           #ユーザーを作成しておく
    end

    describe 'ログイン機能' do
        context 'ユーザーAでログインする' do
            let(:login_user){ user_a }  #ログインユーザーにユーザーAを指定
            include_context 'ユーザーがログインする'

            it_behaves_like 'ログアウトボタンが表示されている'

            it 'ユーザー詳細画面へ遷移している' do
                expect(page).to have_content 'ユーザー詳細画面'
            end
        end

        context '存在しないユーザーでログイン' do
            let(:login_user){ User.new(email: 'not@example.com', password: 'notpassword') }  #ログインユーザーに存在しないユーザーを指定
            include_context 'ユーザーがログインする'

            it 'ログイン画面でログイン情報の間違いのエラーメッセージが表示されている' do
                expect(page).to have_content 'Eメールもしくはパスワードが間違っています'
            end
        end

        context 'Eメールを入力しないでログイン' do
            let(:login_user){ User.new(password: user_a.password) }  #ログインフォームにemailを入力しない
            include_context 'ユーザーがログインする'

            it 'ログイン画面でEメール未入力エラーメッセージが表示されている' do
                expect(page).to have_content 'Eメールを入力してください'
            end
        end

        context 'パスワードを入力しないでログイン' do
            let(:login_user){ User.new(email: user_a.email) }  #ログインフォームにパスワードを入力しない
            include_context 'ユーザーがログインする'

            it 'ログイン画面でパスワード未入力エラーメッセージが表示されている' do
                expect(page).to have_content 'パスワードを入力してください'
            end
        end
    end

    describe 'ログアウト機能' do
        let(:login_user){ user_a }  #ログインユーザーにユーザーAを指定
        include_context 'ユーザーがログインする'
        it_behaves_like 'ログアウトボタンが表示されている'

        context 'ユーザーAでログインしている' do
            before do
                click_link 'ログアウト'
            end

            it 'ログイン画面へ遷移している' do
                expect(page).to have_content 'ログイン画面'
            end

            it 'ログアウトが表示されていない' do
                expect(page).to_not have_content 'ログアウト'
            end
        end
    end
end