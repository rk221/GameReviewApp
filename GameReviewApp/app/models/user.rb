class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :likes_for_user_reviews
end
