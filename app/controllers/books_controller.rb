class BooksController < ApplicationController
  
  def show
    @book=Book.find(params[:id])
  end

  def new
    @book_list=[]
  end
  
  def index
    books=Google::Apis::BooksV1::BooksService.new
    @keyword=params[:keyword]
    @book_list=books.list_volumes(@keyword)
    
  end
  
  def detail
    books=Google::Apis::BooksV1::BooksService.new
    @code=params[:code]
    
    @book_info=books.get_volume(@code)
    if @book_info == nil
      redirect_to 'root'
    end
    
    book_data=current_user.books.find_by(code: @code)
    
    @review=current_user.reviews.find_by(book_id: book_data.id) if book_data
    
  end
end
