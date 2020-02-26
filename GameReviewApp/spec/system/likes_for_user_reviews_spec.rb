require 'rails_helper'


describe 'いいね機能', type: :system do
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

    it 'ログインできているか確認' do
        expect(page).to have_content 'ログアウト'
    end

        describe 'レビュー一覧表示機能' do
        before do
            click_link 'レビュー一覧'
        end

        it 'レビュー一覧画面に遷移している' do
            expect(page).to have_content 'レビュー一覧画面'
        end

        context 'いいねボタンを押す' do
            before do
                click_link '♡'
            end

            it 'いいねボタンが黒色に変化している' do
                expect(page).to have_content '♥'
            end

            context 'いいねを外す' do
                before do
                    click_link '♥'
                end

                it 'いいねが白色に変化している' do
                    expect(page).to have_content '♡'
                end
            end
        end

    end
end
