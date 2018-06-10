class ToppagesController < ApplicationController
  def index
    if logged_in?
      book_ids=Review.where('user_id= ?',current_user.id).select(:book_id)
      @reviews=Review.where(book_id: book_ids)
    end
    # @reviews=Review.all
  end
end
