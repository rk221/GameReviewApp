FactoryBot.define do
    factory :review do
        user_id {1}
        game_id {1}
        title {'title'}
        comment {'comment'}
    end
end