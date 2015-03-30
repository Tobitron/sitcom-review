class ReviewsController < ApplicationController

  def create
  end

  def new
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

  


end
