  class User::FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
      @review = Review.find(params[:review_id])
      favorite = current_user.favorites.new(review_id: @review.id)
      favorite.save
      @review.create_notification_favorite(current_user)
    end
    
    def destroy
      @review = Review.find(params[:review_id])
      favorite = current_user.favorites.find_by(review_id: @review.id)
      favorite.destroy
    end
  end
