class User::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end
  
  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save
    redirect_to books_path
  end

  def index
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
