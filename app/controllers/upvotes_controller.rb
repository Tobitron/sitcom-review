class UpvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @upvote = current_user.votes.new
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @upvote.review_id = params[:review_id]
    user_vote = User.find(current_user.id).votes.where(review_id: @review.id).first

    if user_vote == nil
      @upvote.value = 1
      if @upvote.save
        flash[:notice] = "First vote"
      else
        flash[:notice] = "Something went wrong"
      end
    elsif user_vote.value == 1
      user_vote.update_attributes(value:  0)
      flash[:notice] = "Vote set to 0"
    elsif user_vote.value == 0 || user_vote.value == -1
      user_vote.update_attributes(value:  1)
      flash[:notice] = "Vote set to 1"
    else
      flash[:notice] = "Something Went VERY wrong"
    end

    redirect_to sitcom
  end
end
