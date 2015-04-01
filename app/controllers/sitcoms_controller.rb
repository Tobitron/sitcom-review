class SitcomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :fetch_sitcom, only: [:show, :edit, :destroy, :update]
  # before_action :authorize_user, except: [:index, :show]

  def index
    @sitcoms = Sitcom.order(start_year: :desc)
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
    @reviews = @sitcom.reviews
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
    params.require(:sitcom).permit(:name, :description, :start_year, :end_year, :genre, :network)
  end

  def fetch_sitcom
    @sitcom = Sitcom.find(params[:id])
  end
end

