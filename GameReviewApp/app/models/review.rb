class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_many :reviews

    validates :title, presence: true, length: {maximum: 50}
    validates :comment, presence: true, length: {maximum: 200}
    validates :rate, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}

    mount_uploader :image, ImageUploader
end