class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_many :reviews

    validates :title, presence: true, length: {maximum: 50}
    validates :comment, presence: true, length: {maximum: 200}
    validates :total_hours_played, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 9999}
    validates :graphic_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :sound_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :management_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :story_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
    validates :volume_rate, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

    mount_uploader :image, ImageUploader
end