class User < ApplicationRecord
    has_secure_password
    has_many :reviews
    has_many :likes_for_user_reviews

    validates :name, presence: true, length: {maximum: 30}

    #email validates
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: {maximum: 254}
    validates :password, presence: true, length: {minimum: 8, maximum:128}
end
