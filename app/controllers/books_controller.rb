class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if params[:keyword]
      array = RakutenWebService::Books::Book.search(title: params[:keyword]).map{ _1 }
      @books = Kaminari.paginate_array(array).page(params[:page]).per(10)
    end 
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
    if @book.save
      redirect_to new_book_path(id: @book.title, isbn: @book.isbn), notice: '登録が完了しました'
    else
      render 'books/new'
    end
  end
  
  def index
    @books = Book.page(params[:page]).per(10)
  end

  def show
    @reviews = Review.all
    @book = Book.find_by(isbn: params[:isbn])
    @book_api_data = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
  
  def edit
    @book = Book.find_by(isbn: params[:isbn])
    @book_api_data = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
  end
  
  def update
    @book = Book.find_by(isbn: params[:isbn])
    rbook = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    if @book.update(title: rbook.title, author: rbook.author, image_url: rbook.large_image_url, is_read: params[:is_read] )
      redirect_to book_path(id: @book.title, isbn: @book.isbn), notice: '編集を保存しました'
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find_by(isbn: params[:isbn])
    @book.destroy
    redirect_to books_path, notice: '本の削除が完了しました'
    
  end
  
  private
  
  def isbn_params
    params.permit(:isbn, :is_read)
  end
end
