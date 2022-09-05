class BooksController < ApplicationController
  
  def search
    if params[:keyword]
      @books = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end
  
  def index
  end

  def show
  end
  
  def create
  end
end
