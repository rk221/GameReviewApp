require 'rails_helper'

RSpec.describe Genre, type: :model do
    it "ジャンル名、説明がある場合、有効である" do
        genre = FactoryBot.build(:genre)
        expect(genre).to be_valid
    end

    it "ジャンル名が無い場合、無効である" do
        genre = FactoryBot.build(:genre, name: nil)
        genre.valid?
        expect(genre.errors[:name]).to include("を入力してください")
    end

    it "説明が無い場合、無効である" do
        genre = FactoryBot.build(:genre, description: nil)
        genre.valid?
        expect(genre.errors[:description]).to include("を入力してください")
    end
end