class Review < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_many :reviews

    validates :title, presence: true, length: {maximum: 50}
    validates :comment, presence: true, length: {maximum: 200}

end