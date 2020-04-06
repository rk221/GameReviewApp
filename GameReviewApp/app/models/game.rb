class Game < ApplicationRecord
    has_many :reviews
    belongs_to :genre
    validates :name, presence: true
end