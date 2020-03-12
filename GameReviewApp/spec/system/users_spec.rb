require 'rails_helper'


describe 'ユーザー管理機能', type: :system do
    let(:user_a_data){User.new(name: 'ユーザー本名', nickname: 'ユーザーA', email: 'a@example.com', password: 'password', password_confirmation: 'password')}
    let(:user_a){ FactoryBot.create(:user, name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password: user_a_data.password)}

    describe 'ユーザー登録' do
        before do 
            #ユーザー登録画面へ遷移させる
            visit login_path
            click_link 'ユーザー登録'
        end
    
        it 'ユーザー登録画面へ遷移している' do
            expect(page).to have_content 'ユーザー登録画面'
        end

        context "ユーザー登録画面" do
            shared_context 'ユーザー情報を登録画面へ入力する' do 
                before do
                    fill_in '氏名', with: new_user.name               #氏名を入力する
                    fill_in 'ニックネーム', with: new_user.nickname     #ニックネームを入力する
                    fill_in "Eメール", with: new_user.email           #Eメールを入力する
                    fill_in 'パスワード', with: new_user.password     #パスワードを入力する
                    fill_in 'パスワード（確認）', with: new_user.password_confirmation
                    click_button '登録'                             #ログインするボタンを押す
                end
            end

            context 'ユーザーAを登録する' do
                let(:new_user){user_a_data}
                include_context 'ユーザー情報を登録画面へ入力する'
                it '登録が完了してログイン画面へ遷移している' do
                    expect(page).to have_content 'ログイン画面'
                end
            end
            context '入力せず登録する' do
                context '氏名を入力せずに登録する' do
                    let(:new_user){User.new(nickname: user_a_data.nickname, email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で氏名を入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content '氏名を入力してください'
                    end
                end

                context 'Eメールを入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でEメールを入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content 'Eメールを入力してください'
                    end
                end

                context 'パスワードを入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でパスワードを入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワードを入力してください'
                    end
                end

                context 'パスワード（確認）を入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password: user_a_data.password)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で入力が一致しないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
                    end
                end
            end

            context '使用できない値を入力する' do
                context '不正なEメールを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: 'not@not', password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で不正なEメールの値というエラーメッセージが表示されている' do
                        expect(page).to have_content 'Eメールは不正な値です'
                    end
                end

                context '想定より長い氏名を入力して登録する' do
                    let(:new_user){User.new(name: 'a' * 31, nickname: user_a_data.nickname, email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '30文字で登録されている' do
                        expect(page).to have_content 'ログイン画面'
                    end
                end

                context '想定より長いニックネームを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: 'a' * 31, email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '30文字で登録されている' do
                        expect(page).to have_content 'ログイン画面'
                    end
                end

                context '想定より短いニックネームを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: 'a' * 3, email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でニックネームの長さが足りないエラーメッセージが表示されている' do
                        expect(page).to have_content 'ニックネームは4文字以上で入力してください'
                    end
                end

                context '想定より長いEメールを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: 'a' * 243 + '@example.com', password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録されている' do
                        expect(page).to have_content 'ログイン画面'
                    end
                end

                context '想定より長いパスワードを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password: 'a' * 129, password_confirmation: 'a' * 129)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '128文字で登録されている' do
                        expect(page).to have_content 'ログイン画面'
                    end
                end

                context '想定より短いパスワードを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password: 'a' * 7, password_confirmation: 'a' * 7)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でパスワードの長さ短いエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワードは8文字以上で入力してください'
                    end
                end

                context 'パスワードが確認と一致しない場合に登録する' do
                    let(:new_user){User.new(name: user_a_data.name, nickname: user_a_data.nickname, email: user_a_data.email, password: user_a_data.password, password_confirmation: 'notpassword')}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で入力が一致しないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
                    end
                end
            end
        end
        
    end

    describe 'ユーザー削除' do
        let(:login_user){user_a}
        before do 
            #ユーザー詳細画面へ遷移させる
            visit login_path                                   #URLにアクセスする
            fill_in "Eメール", with: login_user.email           #Eメールを入力する
            fill_in 'パスワード', with: login_user.password     #パスワードを入力する
            click_button 'ログイン'                             #ログインするボタンを押す
        end
    
        it 'ユーザー詳細画面へ遷移している' do
            expect(page).to have_content 'ユーザー詳細画面'
        end

        context 'ユーザーを削除する' do
            before do
                click_link '削除'
            end

            it 'ログイン画面へ遷移している' do
                expect(page).to have_content 'ログイン画面'
            end

            it 'ログアウト表示が消えている' do
                expect(page).to_not have_content 'ログアウト'
            end

            context 'ログイン出来るか本当に消えているか試す' do
                before do                              #URLにアクセスする
                    fill_in "Eメール", with: login_user.email           #Eメールを入力する
                    fill_in 'パスワード', with: login_user.password     #パスワードを入力する
                    click_button 'ログイン'                             #ログインするボタンを押す
                end
            
                it 'ユーザー詳細画面へ遷移していない' do
                    expect(page).to_not have_content 'ユーザー詳細画面'
                end
            end
        end
    end

    describe 'ユーザー詳細' do
        let(:login_user){user_a}
        before do 
            #レビュー作成
            @genre = FactoryBot.create(:genre)
            @game = FactoryBot.create(:game, genre_id: @genre.id)                   
            @review = FactoryBot.create(:review, user_id: login_user.id, game_id: @game.id)
            #ユーザー詳細画面へ遷移させる
            visit login_path                                   #URLにアクセスする
            fill_in "Eメール", with: login_user.email           #Eメールを入力する
            fill_in 'パスワード', with: login_user.password     #パスワードを入力する
            click_button 'ログイン'                             #ログインするボタンを押す
        end
    
        it 'ユーザー詳細画面へ遷移している' do
            expect(page).to have_content 'ユーザー詳細画面'
        end

        it 'レビューが投稿されている' do
            expect(page).to have_content 'タイトル'
            expect(page).to have_content 'ユーザー名'
            expect(page).to have_content 'コメント'
            expect(page).to have_content @review.title
            expect(page).to have_content @review.comment
        end
    end

end