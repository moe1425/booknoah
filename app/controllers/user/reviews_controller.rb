class User::ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  
  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save
    redirect_to books_path
  end

  def index
    @books = Book.all
    @reviews = Review.page(params[:page]).per(10)
  end
  
  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:title, :content, :star)
  end
  
end
