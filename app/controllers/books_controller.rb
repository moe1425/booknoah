class BooksController < ApplicationController
  
  def search
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(author: params[:keyword])
    end 
  end
  
  def index
  end

  def show
    @book = RakutenWebService::Books::Book.search(title: params[:keyword])
  end
  
  def create
  end
end
