class HomeController < ApplicationController
  def index
    @topreviews = Review.joins(:likes_for_user_reviews).select("reviews.*").where("reviews.created_at > ?", 1.month.ago).group(:id).order('count(*) desc').limit(10)
    @topgames = Game.joins(:reviews).select("games.*, reviews.game_id, reviews.created_at").where("reviews.created_at > ?", 1.month.ago).group(:game_id).order('count(*) desc').limit(3)
    @reviews = Review.all.limit(10)
  end
end
