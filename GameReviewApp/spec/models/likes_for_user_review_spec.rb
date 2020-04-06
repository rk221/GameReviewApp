require 'rails_helper'

RSpec.describe LikesForUserReview, type: :model do
    let(:genre){FactoryBot.create(:genre)}
    let(:game){FactoryBot.create(:game, genre_id: genre.id)}
    let(:user){FactoryBot.create(:user)}
    let(:review){FactoryBot.create(:review, game_id: game.id, user_id: user.id)}

    it "ユーザーIDとレビューIDがある場合、有効である" do
        like = FactoryBot.build(:likes_for_user_review, user_id: user.id, review_id: review.id)
        expect(like).to be_valid
    end

    it "ユーザーIDが無い場合、無効である" do
        like = FactoryBot.build(:likes_for_user_review, user_id: nil, review_id: review.id)
        like.valid?
        expect(like.errors[:user]).to include("を入力してください")
    end

    it "レビューIDが無い場合、無効である" do
        like = FactoryBot.build(:likes_for_user_review, user_id: user.id, review_id: nil)
        like.valid?
        expect(like.errors[:review]).to include("を入力してください")
    end
end