require 'rails_helper'


describe 'トップページ', type: :system do
    let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', nickname: 'ユーザーA', email: 'a@example.com')}
    let(:login_user){user_a}
    before do
        @genre = FactoryBot.create(:genre)
        @game = FactoryBot.create(:game, genre_id: @genre.id)                   
        @review = FactoryBot.create(:review, user_id: user_a.id, game_id: @game.id)
        visit login_path                           
        fill_in "Eメール", with: login_user.email     
        fill_in 'パスワード', with: login_user.password 
        click_button 'ログイン'                      
    end

    it 'ログインできているか確認' do
        expect(page).to have_content 'ログアウト'
    end

    context '要素確認' do
        let(:user_b){FactoryBot.create(:user, name: 'ユーザーB', nickname: 'ユーザーB', email: 'b@example.com')}
        before do
            FactoryBot.create(:review, title: 'タイトルA', comment: 'コメントA', user_id: user_a.id, game_id: @game.id)
        end

        it 'トレンドゲームが表示されている' do
            expect(page).to have_content 'トレンドゲームＴＯＰ３'
            expect(page).to have_content @game.name
        end

        it '新着レビューが表示されている' do
            expect(page).to have_content '新着レビュー'
            expect(page).to have_content @review.title
            expect(page).to have_content @review.comment
        end

        context '人気レビュー確認' do
            before do 
                FactoryBot.create(:likes_for_user_review, user_id: user_a.id, review_id: @review.id)
            end
            it '新着レビューが表示されている' do
                expect(page).to have_content '人気レビュー'
                expect(page).to have_content @review.title
                expect(page).to have_content @review.comment
            end
        end
    end
end