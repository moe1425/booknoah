class BooksController < ApplicationController
  
  def search
    if params[:keyword]
      array = RakutenWebService::Books::Book.search(author: params[:keyword]).map{ _1 }
      @books = Kaminari.paginate_array(array).page(params[:page]).per(20)
    end 
  end
  
  def index
    @books = Book.all
  end

  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
  
 
  def new
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
  
  def create
    @book = Book.new(isbn_params)
    rbook = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @book.title = rbook.title
    @book.author = rbook.author
    @book.image_url = rbook.large_image_url
    @book.save
    redirect_to new_book_path(id: @book.title, isbn: @book.isbn)
  end
  
  def edit
    @book = Book.find(isbn_params)
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
  
  def update
    @book = Book.find(isbn_params)
    rbook = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @book.title = rbook.title
    @book.author = rbook.author
    @book.image_url = rbook.large_image_url
    @book.update
    redirect_to book_path(id: @book.title, isbn: @book.isbn)
  end
  
  def destroy
  end
  
  private
  
  def isbn_params
    params.permit(:isbn, :is_read)
  end
end
