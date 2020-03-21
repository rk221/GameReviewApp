class ChangeReviewsIdToLikesForUserReviews < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :likes_for_user_reviews, :review
    add_foreign_key :likes_for_user_reviews, :review, on_delete: :cascade
  end
end
