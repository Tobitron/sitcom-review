class DownvotesController < ApplicationController

  def create
    @downvote = current_user.votes.new
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @downvote.review_id = params[:review_id]
    @downvote.value = -1
    unless @upvote.save
      flash[:notice] = "Something went wrong."
    end
    redirect_to sitcom
  end
end
