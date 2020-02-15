require 'rails_helper'


describe 'ユーザー管理機能', type: :system do
    let(:user_a_data){User.new(name: 'ユーザーA', email: 'a@example.com', password: 'password', password_confirmation: 'password')}
    let(:user_a){ FactoryBot.create(user_a_data)}

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
                    fill_in '名前', with: new_user.name               #名前を入力する
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
                context '名前を入力せずに登録する' do
                    let(:new_user){User.new(email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で名前を入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content '名前を入力してください'
                    end
                end

                context 'Eメールを入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でEメールを入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content 'Eメールを入力してください'
                    end
                end

                context 'パスワードを入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: user_a_data.email, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でパスワードを入力していないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワードを入力してください'
                    end
                end

                context 'パスワード（確認）を入力せずに登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: user_a_data.email, password: user_a_data.password)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で入力が一致しないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
                    end
                end
            end

            context '使用できない値を入力する' do
                context '不正なEメールを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: 'not@not', password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で不正なEメールの値というエラーメッセージが表示されている' do
                        expect(page).to have_content 'Eメールは不正な値です'
                    end
                end

                context '想定より長い名前を入力して登録する' do
                    let(:new_user){User.new(name: 'あいうえおかきくけこさしすせそなにぬねのはひふへほまみむめもや', email: user_a_data.email, password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で名前の長さ超過のエラーメッセージが表示されている' do
                        expect(page).to have_content '名前は30文字以内で入力してください'
                    end
                end

                context '想定より長いEメールを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@example.com', password: user_a_data.password, password_confirmation: user_a_data.password_confirmation)}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でEメールの長さ超過のエラーメッセージが表示されている' do
                        expect(page).to have_content 'Eメールは254文字以内で入力してください'
                    end
                end

                context '想定より長いパスワードを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: user_a_data.email, password: '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111', password_confirmation: '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111')}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でパスワードの長さ超過のエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワードは128文字以内で入力してください'
                    end
                end

                context '想定より短いパスワードを入力して登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: user_a_data.email, password: '1234567', password_confirmation: '1234567')}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面でパスワードの長さ短いエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワードは8文字以上で入力してください'
                    end
                end

                context 'パスワードが確認と一致しない場合に登録する' do
                    let(:new_user){User.new(name: user_a_data.name, email: user_a_data.email, password: user_a_data.password, password_confirmation: 'notpassword')}
                    include_context 'ユーザー情報を登録画面へ入力する'
                    it '登録画面で入力が一致しないエラーメッセージが表示されている' do
                        expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
                    end
                end
            end
        end
        
    end

end