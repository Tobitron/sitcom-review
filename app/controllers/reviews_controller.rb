class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = Review.new
  end

  def create
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = current_user.reviews.new(review_params)
    @review.sitcom = @sitcom
    @review.rating = params[:score]
    if @review.save
      ReviewNotifier.new_review(@review).deliver_later
      flash[:notice] = 'Successfully created your review.'
      redirect_to @sitcom
    else
      flash[:alert] = @review.errors.full_messages
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
    @sitcom = @review.sitcom
  end

  def update
    @review = Review.find(params[:id])
    @sitcom = @review.sitcom

    if @review.update(review_params)
      flash[:notice] = 'Review updated!'
      redirect_to sitcom_path(@sitcom)
    else
      flash[:alert] = @review.errors.full_messages
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @sitcom = @review.sitcom
    if @review.destroy
      flash[:notice] = "Review deleted"
    end  
    redirect_to sitcom_path(@sitcom)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating, :score)
  end
end
