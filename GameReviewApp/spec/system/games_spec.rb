require 'rails_helper'


describe 'ゲーム管理機能', type: :system do
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

    describe 'ゲーム一覧表示機能' do
        before do
            click_link 'ゲーム一覧'
        end

        it 'ゲーム一覧画面に遷移している' do
            expect(page).to have_content 'ゲーム一覧画面'
        end

        it 'ゲームが１件表示されている' do
            expect(page).to have_content @game.name
        end
    end

    describe 'ゲーム詳細表示機能' do
        before do
            click_link 'ゲーム一覧'
            click_link @game.name
        end

        it 'ゲーム詳細画面へ遷移している' do
            expect(page).to have_content 'ゲーム詳細画面'
        end

        it 'ゲームのレビューが表示されている' do
            expect(page).to have_content @review.title
            expect(page).to have_content @review.comment
        end
    end

end