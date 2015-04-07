class UpvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = current_user.votes.new
    review = Review.find(params[:review_id])
    sitcom = review.sitcom
    vote.review_id = params[:review_id]

    VoteManager.new(current_user, review, vote).upvote
    redirect_to sitcom
  end
end
