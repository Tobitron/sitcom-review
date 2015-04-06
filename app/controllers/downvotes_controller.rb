class DownvotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @downvote = current_user.votes.new
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @downvote.review_id = params[:review_id]
    user_vote = User.find(current_user.id).votes.where(review_id: @review.id)

    if user_vote.first == nil
      @downvote.value = -1
      if @downvote.save
        flash[:notice] = "First downvote"
      else
        flash[:notice] = "Something went wrong"
      end
    elsif user_vote.first.value == -1
      user_vote.first.update_attributes(value:  0)
      flash[:notice] = "Vote set to 0"
    elsif user_vote.first.value == 0 || user_vote.first.value == 1
      user_vote.first.update_attributes(value:  -1)
      flash[:notice] = "Vote set to -1"
    else
      flash[:notice] = "Something Went VERYYYYY wrong"
    end

    redirect_to sitcom
  end
end
