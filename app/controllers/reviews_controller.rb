class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      flash[:notice] = 'Successfully created your review.'
    else
      flash[:alert] = @review.errors.full_messages
    end
    redirect_to reviews_path
  end

  def index
    @reviews = Review.all.limit(10)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
