class DownvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])

    VoteManager.new(current_user, review).downvote
    redirect_to review.sitcom
  end
end
