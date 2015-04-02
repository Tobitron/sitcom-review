class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @reviews = Review.newest_first.page params[:page]
  end

  def new
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = Review.new
  end

  def create
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = current_user.reviews.new(review_params)
    @review.sitcom = @sitcom
    if @review.save
      flash[:notice] = 'Successfully created your review.'
      redirect_to @sitcom
    else
      flash[:alert] = @review.errors.full_messages
      render :new
    end
  end

  def edit
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = @sitcom.reviews.find(params[:id])
  end

  def update
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = @sitcom.reviews.find(params[:id])

    if @review.update(review_params)
      flash[:notice] = 'Review updated!'
      redirect_to sitcom_path(@sitcom)
    else
      render :edit
    end
  end

  def destroy
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = Review.find(params[:id])
    if @review.destroy
      flash[:notice] = "Review deleted"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to sitcom_path(@sitcom)
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end
end
