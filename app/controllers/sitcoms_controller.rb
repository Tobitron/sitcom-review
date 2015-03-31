class SitcomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :fetch_sitcom, only: [:show, :edit, :destroy]

  def index
    @sitcoms = Sitcom.all.limit(20).sort_by { |sitcom| sitcom.start_year }.reverse
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
  end

  def edit
  end

  def update
    @sitcom = current_user.sitcoms.find(params[:id])
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
