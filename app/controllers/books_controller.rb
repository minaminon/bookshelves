class BooksController < ApplicationController
  before_action :require_user_logged_in,only: [:show,:new,:index,:detail]
  def show
    @book=Book.find(params[:id])
  end

  def new
    @book_list=[]
  end
  
  def index
    books=Google::Apis::BooksV1::BooksService.new
    @keyword=params[:keyword]
    unless @keyword == ''
      @book_lists=books.list_volumes(@keyword,max_results: 40)
    end
      
    #@book_list=@book_lists if @book_lists
    @book_list=Kaminari.paginate_array(@book_lists.items).page(params[:page]).per(5) if @book_lists
    
  end
  
  def detail
    books=Google::Apis::BooksV1::BooksService.new
    @code=params[:code]
    
    @book_info=books.get_volume(@code)
    if @book_info == nil
      redirect_to 'root'
    end
    
    @book_data=Book.find_by(code: @code)
    
    @reviews=current_user.reviews.find_by(book_id: @book_data)
    
  end
end
