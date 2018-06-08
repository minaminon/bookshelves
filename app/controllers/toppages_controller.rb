class ToppagesController < ApplicationController
  def index
    @reviews=Review.all
  end
end
