class SitcomsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @sitcoms = Sitcom.all.limit(20)
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
    @sitcom = Sitcom.find(params[:id])
    @reviews = @sitcom.reviews
  end

  private

  def sitcom_params
    params.require(:sitcom).permit(:name, :description, :start_year, :end_year, :genre, :network)
  end
end
