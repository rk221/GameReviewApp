FactoryBot.define do
    factory :user do
        name {'テストユーザー'}
        nickname{'ニックネーム'}
        email {'test@example.com'}
        password {'password'}
    end
end