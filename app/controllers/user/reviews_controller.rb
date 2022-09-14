class User::ReviewsController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: [:edit]
  
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  
  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save
    redirect_to reviews_path
  end

  def index
    @reviews = current_user.reviews.page(params[:page]).per(10)
  end
  
  def favorites
    favorites = @review.favorites.find_by(params[:id])
    @favorite_users = User.find(favorites)
  end

  def edit
    @review = Review.find(params[:id])
    @book = Book.find(params[:id])
  end
  
  def update
    @review = Review.find_by(params[:id])
    @review.update(review_params)
    redirect_to reviews_path
  end
  
  def destroy
    @book = Book.find(params[:id])
    @review = Review.find_by(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
  
  private
  
  def review_params
    params.require(:review).permit(:title, :content, :star)
  end
  
end
