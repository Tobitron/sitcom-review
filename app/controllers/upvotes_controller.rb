class UpvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.new
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @vote.review_id = params[:review_id]

    unless current_user.votes.where(review_id: @review.id).length > 1
      user_vote = current_user.user_vote_by_review(@review)

      if user_vote == nil
        @vote.first_upvote
      elsif user_vote.is_upvote?
        user_vote.to_neutral
      elsif user_vote.is_neutral? || user_vote.is_downvote?
        user_vote.to_upvote
      else
        flash[:notice] = "Something Went VERY wrong"
      end
      redirect_to sitcom

    else
      flash[:alert] = "Something Went VERY wrong"
      redirect_to sitcom
    end
  end
end
