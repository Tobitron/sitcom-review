class SearchesController < ApplicationController
  def index
    @sitcoms = Sitcom.search(params[:search]).page params[:page]
  end
end
