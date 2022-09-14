  class User::FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
      @review = Review.find_by(params[:review_id])
      favorite = current_user.favorites.new(review_id: @review.id)
      favorite.save
      redirect_to request.referer
    end
    
    def destroy
      @review = Review.find_by(params[:review_id])
      favorite = current_user.favorites.find_by(review_id: @review.id)
      favorite.destroy
      redirect_to request.referer
    end
  end
