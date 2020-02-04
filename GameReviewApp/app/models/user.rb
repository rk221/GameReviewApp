class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :likes_for_user_reviews

    validates :name, presence: true
    #email validates
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    
end
