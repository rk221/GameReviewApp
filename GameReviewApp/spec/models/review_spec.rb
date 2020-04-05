require 'rails_helper'

RSpec.describe Review, type: :model do
    let(:genre){FactoryBot.create(:genre)}
    let(:game){FactoryBot.create(:game, genre_id: genre.id)}
    let(:user){FactoryBot.create(:user)}
    it "タイトル、コメント、ユーザーID、ゲームIDがある場合、有効である" do
        review = FactoryBot.build(:review, user_id: user.id, game_id: game.id)
        expect(review).to be_valid
    end

    it "タイトル、コメント、ユーザーID、ゲームID、評価（５種類）がある場合、有効である" do
        review = FactoryBot.build(:review, user_id: user.id, game_id: game.id, graphic_rate: 1, sound_rate: 1, management_rate: 1, story_rate: 1, volume_rate: 1)
        expect(review).to be_valid
    end

    it "タイトルが無い場合、無効である" do
        review = FactoryBot.build(:review, title: nil, user_id: user.id, game_id: game.id)
        review.valid?
        expect(review.errors[:title]).to include("を入力してください")
    end

    it "コメントが無い場合、無効である" do
        review = FactoryBot.build(:review, comment: nil, user_id: user.id, game_id: game.id)
        review.valid?
        expect(review.errors[:comment]).to include("を入力してください")
    end

    it "タイトルが51文字以上の場合、無効である" do
        review = FactoryBot.build(:review, title: 'a' * 51, user_id: user.id, game_id: game.id)
        review.valid?
        expect(review.errors[:title]).to include("は50文字以内で入力してください")
    end

    it "コメントが201文字以上の場合、無効である" do
        review = FactoryBot.build(:review, comment: 'a' * 201, user_id: user.id, game_id: game.id)
        review.valid?
        expect(review.errors[:comment]).to include("は200文字以内で入力してください")
    end

    it "評価が1未満の場合、有効である" do
        review = FactoryBot.build(:review, user_id: user.id, game_id: game.id, graphic_rate: 0)
        review.valid?
        expect(review.errors[:graphic_rate]).to include("は1以上の値にしてください")
    end

    it "評価が6以上の場合、有効である" do
        review = FactoryBot.build(:review, user_id: user.id, game_id: game.id, graphic_rate: 6)
        review.valid?
        expect(review.errors[:graphic_rate]).to include("は5以下の値にしてください")
    end
end