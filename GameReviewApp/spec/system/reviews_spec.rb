require 'rails_helper'


describe 'レビュー管理機能', type: :system do
    let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:login_user){user_a}
    before do
        FactoryBot.create(:game)                            #ゲームを作成
        visit login_path                                   #URLにアクセスする
        fill_in "Eメール", with: login_user.email           #Eメールを入力する
        fill_in 'パスワード', with: login_user.password     #パスワードを入力する
        click_button 'ログイン'                             #ログインするボタンを押す
    end
    #ログインできているか確認
    it { expect(page).to have_content 'ログアウト'}             #ログアウトが表示されているか確認

    describe 'レビュー投稿機能' do
        shared_context 'レビュー内容を入力し投稿' do 
            before do
                fill_in "タイトル", with: review.title          #タイトルを入力する
                fill_in 'コメント', with: review.comment        #コメントを入力する
                click_button '投稿'                         #投稿ボタンを押す
            end
        end

        before do
            click_link 'レビュー投稿'
        end

        context 'レビュー投稿を行う' do
            let(:review){ Review.new(title: 'title', comment: 'comment')}
            include_context 'レビュー内容を入力し投稿'

            it '正常に投稿されている' do
                expect(page).to have_content 'title'
                expect(page).to have_content 'comment'
            end
        end
        context '入力せずに登録する' do
            context 'タイトルを入力せずに投稿を行う' do
                let(:review){ Review.new(title: '', comment: 'comment')}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でタイトル未入力エラーメッセージが表示されている' do
                    expect(page).to have_content 'タイトルを入力してください'
                end
            end

            context 'コメントを入力せずに投稿を行う' do
                let(:review){ Review.new(title: 'title', comment: '')}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でコメント未入力エラーメッセージが表示されている' do
                    expect(page).to have_content 'コメントを入力してください'
                end
            end
        end

        context '使用できない値を入力する' do
            context '想定より長いタイトルを入力して投稿を行う' do
                let(:review){ Review.new(title: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', comment: 'comment')}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でタイトルの長さ超過のエラーメッセージが表示されている' do
                    expect(page).to have_content 'タイトルは50文字以内で入力してください'
                end
            end

            context '想定より長いコメントを入力して投稿を行う' do
                let(:review){ Review.new(title: 'title', comment: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でコメントの長さ超過のエラーメッセージが表示されている' do
                    expect(page).to have_content 'コメントは200文字以内で入力してください'
                end
            end
        end
    end

    describe 'レビュー一覧表示機能' do
        before do
            FactoryBot.create(:review)
            click_link 'レビュー一覧'
        end

        it 'レビューが正しく表示されている' do
            expect(page).to have_content 'title'
            expect(page).to have_content 'comment'
        end
    end

end