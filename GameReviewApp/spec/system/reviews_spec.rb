require 'rails_helper'


describe 'レビュー管理機能', type: :system do
    let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', nickname: 'ユーザーA', email: 'a@example.com')}
    let(:login_user){user_a}
    before do
        @genre = FactoryBot.create(:genre)
        @game = FactoryBot.create(:game, genre_id: @genre.id)
        visit login_path                           
        fill_in "Eメール", with: login_user.email        
        fill_in 'パスワード', with: login_user.password   
        click_button 'ログイン'                 
    end
    #ログインできているか確認
    it { expect(page).to have_content 'ログアウト'}       

    describe 'レビュー投稿機能' do
        shared_context 'レビュー内容を入力し投稿' do 
            before do
                fill_in "タイトル", with: review.title     
                fill_in 'コメント', with: review.comment     
                fill_in '総プレイ時間', with: review.total_hours_played
                click_button '投稿'                  
            end
        end

        before do
            click_link 'レビュー投稿'
        end

        context 'レビュー投稿を行う' do
            let(:review){ Review.new(title: 'title', comment: 'comment', total_hours_played: 5)}
            include_context 'レビュー内容を入力し投稿'

            it '正常に投稿されている' do
                expect(page).to have_content 'title'
                expect(page).to have_content 'comment'
                expect(page).to have_content '5'
                expect(page).to have_content '総プレイ時間'
            end
        end
        context '入力せずに登録する' do
            context 'タイトルを入力せずに投稿を行う' do
                let(:review){ Review.new(title: '', comment: 'comment', total_hours_played: 5)}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でタイトル未入力エラーメッセージが表示されている' do
                    expect(page).to have_content 'タイトルを入力してください'
                end
            end

            context 'コメントを入力せずに投稿を行う' do
                let(:review){ Review.new(title: 'title', comment: '', total_hours_played: 5)}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でコメント未入力エラーメッセージが表示されている' do
                    expect(page).to have_content 'コメントを入力してください'
                end
            end
            
            context '総プレイ時間を入力せずに投稿を行う' do
                let(:review){ Review.new(title: 'title', comment: 'comment', total_hours_played: '')}
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面でコメント未入力エラーメッセージが表示されている' do
                    expect(page).to have_content '総プレイ時間を入力してください'
                end
            end
        end

        context '使用できない値を入力する' do
            context '想定より長いタイトルを入力して投稿を行う' do
                let(:review){ Review.new(title: 'a' * 51, comment: 'comment', total_hours_played: 5)}
                include_context 'レビュー内容を入力し投稿'

                it '入力制限で50文字で投稿されている' do
                    expect(page).to have_content 'a'*50
                end
            end

            context '想定より長いコメントを入力して投稿を行う' do
                let(:review){ Review.new(title: 'title',  comment: 'a' * 201, total_hours_played: 5) }
                include_context 'レビュー内容を入力し投稿'

                it '入力制限で200文字で投稿されている' do
                    expect(page).to have_content 'a'*200
                end
            end
            context '総プレイ時間に0を入力して投稿を行う' do
                let(:review){ Review.new(title: 'title',  comment: 'comment', total_hours_played: 0) }
                include_context 'レビュー内容を入力し投稿'

                it 'レビュー投稿画面から移動していない' do
                    expect(page).to have_content 'レビュー登録画面'
                end
            end
        end
    end

    describe 'レビュー一覧表示機能' do
        before do
            @review = FactoryBot.create(:review, user_id: user_a.id, game_id: @game.id)
            click_link 'レビュー一覧'
        end

        it 'レビューが正しく表示されている' do
            expect(page).to have_content @review.title
            expect(page).to have_content @review.comment
        end
    end

    describe 'レビュー削除機能' do
        before do
            @review = FactoryBot.create(:review, comment: "削除用レビュー", user_id: user_a.id, game_id: @game.id)
            click_link 'レビュー一覧'
        end

        it 'レビューが正しく表示されている' do
            expect(page).to have_content @review.title
            expect(page).to have_content @review.comment
        end

        context 'レビューを削除する' do
            before do
                click_link '削除'
                page.driver.browser.switch_to.alert.accept #ダイアログOKクリック
            end

            it 'レビューが削除されている' do
                expect(page).to_not have_content @review.title
                expect(page).to_not have_content @review.comment
            end
        end
    end
end