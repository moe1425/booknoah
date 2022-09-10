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
  end
  
  def create
    @book = Book.new(isbn_params)
    rbook = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @book.title = rbook.title
    @book.author = rbook.author
    @book.image_url = rbook.large_image_url
    @book.save
    redirect_to book_path(id: @book.title, isbn: @book.isbn)
  end
  
  private
  
  def isbn_params
    params.permit(:isbn, :is_read)
  end
end
