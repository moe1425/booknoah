class BooksController < ApplicationController
  
  def search
    if params[:keyword]
      array = RakutenWebService::Books::Book.search(author: params[:keyword]).map{ _1 }
      @books = Kaminari.paginate_array(array).page(params[:page]).per(20)
    end 
  end
  
  def index
  end

  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    # byebug
  end
  
  def create
  end
end
