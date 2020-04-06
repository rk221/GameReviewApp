require 'rails_helper'

RSpec.describe Game, type: :model do
    let(:genre){FactoryBot.create(:genre)}
    it "ゲーム名、ジャンルIDがある場合、有効である" do
        game = FactoryBot.build(:game, genre_id: genre.id)
        expect(game).to be_valid
    end

    it "ゲーム名が無い場合、無効である" do
        game = FactoryBot.build(:game, name: nil, genre_id: genre.id)
        game.valid?
        expect(game.errors[:name]).to include("を入力してください")
    end

    it "ジャンルIDが無い場合、無効である" do
        game = FactoryBot.build(:game, genre_id: nil)
        game.valid?
        expect(game.errors[:genre]).to include("を入力してください")
    end
end