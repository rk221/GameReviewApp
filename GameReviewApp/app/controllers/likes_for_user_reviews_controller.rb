class LikesForUserReviewsController < ApplicationController
    def create
        @likes_for_user_review = LikesForUserReview.create(review_id: params[:review_id], user_id: current_user.id)
    end

    def destroy
        LikesForUserReview.find_by(review_id: params[:review_id], user_id: current_user.id).destroy
    end
end
