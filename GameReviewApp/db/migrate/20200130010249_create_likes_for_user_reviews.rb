class CreateLikesForUserReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :likes_for_user_reviews do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.timestamps
      t.index [:user_id, :review_id], unique: true
    end
  end
end
