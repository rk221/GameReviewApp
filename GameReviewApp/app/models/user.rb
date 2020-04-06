class User < ApplicationRecord
    has_secure_password
    has_many :reviews, dependent: :destroy
    has_many :likes_for_user_reviews, dependent: :destroy

    validates :name, presence: true, length: {maximum: 30}
    validates :nickname, presence: true, length: {minimum:4, maximum: 30}

    #email validates
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: {maximum: 254}
    validates :password, presence: true, length: {minimum: 8, maximum:128}, allow_nil: true

    attr_accessor :remember_token

    #渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    #ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    #ユーザーのログイン情報を破棄
    def forget
        update_attribute(:remember_digest, nil)
    end
end
