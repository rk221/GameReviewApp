require 'rails_helper'


describe 'ジャンル管理機能', type: :system do
    let(:user_a){FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
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
    #ログインできているか確認
    it { expect(page).to have_content 'ログアウト'}     

    describe 'ジャンル一覧機能' do
        before do
            click_link 'ジャンル一覧'
        end

        it 'ジャンルが表示されている' do
            expect(page).to have_content @genre.name
        end
    end

    describe 'ジャンル詳細機能' do
        before do
            click_link 'ジャンル一覧'
            click_link @genre.name
        end

        it 'ジャンルに対応したレビューが表示されている' do
            expect(page).to have_content @review.title 
            expect(page).to have_content @review.comment
        end
    end
end