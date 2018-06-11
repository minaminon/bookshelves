class ReviewsController < ApplicationController
  
  include BooksHelper
  
  def create
    @code=params[:code]
    status=params[:status]
    content=params[:content]
    @book=Book.find_or_initialize_by(code: @code)
    unless @book.persisted?
      books=Google::Apis::BooksV1::BooksService.new
      book_info=books.get_volume(@code)
      @book=Book.new(optimize_column(@code,book_info))
      @book.save
      
    end
    current_user.add(@book,status,content)
    flash[:success] = 'レビューを追加しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @id=params[:id]
    current_user.remove(@id)
    flash[:success] = 'レビューを削除しました'
    redirect_back(fallback_location: root_path)
    
  end
  
  def show
    @id=params[:id]
    @review=Review.find(@id)
  end
  
  def update
    @review=Review.find(params[:id])
    if @review.update(strong_params)
      flash[:id]='正常に更新されました'
      redirect_to @review
    else
      flash.now[:danger]='更新に失敗しました'
      redirect_to root_path
    end
  end
  
  private 

  def strong_params
    params.require(:review).permit(:user_id,:book_id,:content,:status)
  end
end
