class Game < ApplicationRecord
    has_many :reviews
    has_many :likes_for_user_reviews
end
