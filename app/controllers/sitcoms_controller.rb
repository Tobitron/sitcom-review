class SitcomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_sitcom, only: [:show, :edit, :destroy, :update]

  def index
    unless params[:search] == nil
      sitcom_manager_with_search = SitcomManager.new(params[:search], params[:page])

      @sitcoms = Sitcom.search(params[:search]).page params[:page]

      @newest_sitcoms = sitcom_manager_with_search.newest_sitcoms
      @highest_rated = sitcom_manager_with_search.highest_rated
      @most_reviewed = sitcom_manager_with_search.most_reviewed
    else
      sitcom_manager_without_search = SitcomManager.new(nil, params[:page])

      @sitcoms = Sitcom.order(start_year: :desc).page params[:page]

      @newest_sitcoms = sitcom_manager_without_search.newest_sitcoms
      @highest_rated = sitcom_manager_without_search.highest_rated
      @most_reviewed = sitcom_manager_without_search.most_reviewed
    end
  end

  def new
    @sitcom = Sitcom.new
  end

  def create
    @sitcom = current_user.sitcoms.build(sitcom_params)
    if @sitcom.save
      flash[:notice] = 'You have successfully added a sitcom!'
      redirect_to @sitcom
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  def show
    @reviews = Kaminari.paginate_array(@sitcom.reviews.sort_by { |review| review.sum_of_votes }.reverse).page params[:page]
    @avg_rating = 0
    @avg_rating = @sitcom.reviews.average(:rating).round(2) unless @sitcom.reviews.blank?
  end

  def edit
  end

  def update
    if @sitcom.update(sitcom_params)
      flash[:notice] = 'Sitcom Updated'
      redirect_to sitcom_path
    else
      flash[:alert] = 'Error: Sitcom not updated'
      render :edit
    end
  end

  def destroy
    if @sitcom.destroy
      flash[:notice] = 'Sitcom Deleted'
      redirect_to root_path
    else
      flash[:alert] = 'Error: Sitcom not Deleted'
      render :show
    end
  end

  private

  def sitcom_params
    params.require(:sitcom).permit(:name, :description, :start_year, :end_year, :genre, :network, :image)
  end

  def fetch_sitcom
    @sitcom = Sitcom.find(params[:id])
  end
end
