class ReviewsController < ApplicationController
    def index
        @reviews = Review.all
    end

    def new
        @review = Review.new
    end

    def create
        @review = Review.new(review_params)
        @review.user_id = current_user.id
        if @review.save
            redirect_to reviews_path, notice: 'レビューを投稿しました'
        else
            render :new
        end
    end

    def destroy
        review = Review.find(params[:id])
        review.destroy 
        redirect_back(fallback_location: root_path, notice: 'レビューを削除しました') 
    end
    
    private

    def review_params
        params.require(:review).permit(:id, :title, :comment, :total_hours_played, :game_id, :user_id, :image, :graphic_rate, :sound_rate, :management_rate, :story_rate, :volume_rate)
    end


end
