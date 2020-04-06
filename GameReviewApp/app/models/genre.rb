class Genre < ApplicationRecord
    has_many :games
    validates :name, presence: true
    validates :description, presence: true
end
