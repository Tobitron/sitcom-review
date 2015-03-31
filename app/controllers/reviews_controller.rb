class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @reviews = Review.all.limit(10)
  end

  def new
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = Review.new
  end

  def create
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = current_user.reviews.new(review_params)
    @review.sitcom_id = @sitcom.id
    if @review.save
      flash[:notice] = 'Successfully created your review.'
      redirect_to sitcom_path(@sitcom)
    else
      flash[:alert] = @review.errors.full_messages
      render :new
    end
  end

  def edit
    @sitcom = Sitcom.find(params[:sitcom_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @sitcom = Sitcom.find(params[:sitcom_id])
    if @review.update_attributes(review_params)
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
