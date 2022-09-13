class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if params[:keyword]
      array = RakutenWebService::Books::Book.search(title: params[:keyword]).map{ _1 }
      @books = Kaminari.paginate_array(array).page(params[:page]).per(10)
    end 
  end
  
  def new
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    rbook = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @book.title = rbook.title
    @book.author = rbook.author
    @book.image_url = rbook.large_image_url
    @book.item_url = rbook.item_url
  end
  
  def create
    @book = Book.find_or_initialize_by(isbn: params.dig(:book, :isbn))
    @book.assign_attributes(book_params)
    if @book.save
      @user_book = current_user.user_books.find_or_initialize_by(book_id: @book.id)
      @user_book.is_read =params.dig(:book, :is_read)
      @user_book.save!
      redirect_to book_path(@book), notice: '登録が完了しました'
    else
      render 'books/new'
    end
  end
  
  def index
    @books = current_user.books.page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end
  
  def edit
    @book = Book.find(params[:id])
    @user_book = current_user.user_books.find_by(book_id: @book.id)
  end
  
  def update
    @book = Book.find(params[:id])
    @user_book = current_user.user_books.find_by(book_id: @book.id)
    if @user_book.update(user_book_params)
      redirect_to book_path(@book), notice: '編集を保存しました'
    else
      render :edit
    end
  end
  
  def destroy
    @user_book = current_user.user_books.find_by(book_id: params[:id])
    @user_book.destroy if @user_book
    redirect_to books_path, notice: '本の削除が完了しました'
    
  end
  
  private
  
  def book_params
    params.require(:book).permit(:isbn, :title, :author, :image_url, :item_url, :is_read)
  end
  
  def user_book_params
    params.require(:book).permit(:is_read)
  end
end
