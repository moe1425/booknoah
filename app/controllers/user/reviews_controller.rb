class User::ReviewsController < ApplicationController
  
  def new
    @review = Review.new
  end
  
  def create
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @review = current_user.review.new(id: @book.title, isbn: @book.isbn)
    review.save
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
  
end
