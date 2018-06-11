class ToppagesController < ApplicationController
  def index
    if logged_in?
      book_ids=Review.where('user_id= ?',current_user.id).select(:book_id)
      @reviews=Review.where(book_id: book_ids).order("updated_at DESC").page(params[:page]).per(5)
     # @reviews=Review.page(params[:page]).per(5)
    end
    # @reviews=Review.all
  end
end
