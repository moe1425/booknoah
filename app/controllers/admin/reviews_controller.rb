  class Admin::ReviewsController < ApplicationController
    
    def index
      @reviews = Review.all.page(params[:page]).per(10)
    end
    
    def show
      @review = Review.find(params[:id])
    end
    
    def edit
      @review = Review.find(params[:id])
    end
    
    def update
      @review = Review.find(params[:id])
      @review.update(review_params)
    redirect_to admin_review_path(@review.id)
    end
    
    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to admin_reviews_path
    end
    
    private
    
    def review_params
      params.require(:review).permit(:title, :content, :star)
    end
    
  end
