class UpvotesController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   @upvote = Vote.new
  #   @review = Review.find(params[:review_id])
  # end

  def create
    @upvote = current_user.votes.new
    @review = Review.find(params[:review_id])
    sitcom = @review.sitcom
    @upvote.review_id = params[:review_id]
    user_vote = User.find(current_user.id).votes.where(review_id: @review.id)
    # @upvote.value = 1
      binding.pry
    if user_vote.first.value == 1
      user_vote.first.value = 0
      flash[:notice] = "Vote set to 0"
    elsif user_vote.first.value == 0
      user_vote.first.value = 1
      flash[:notice] = "Vote set to 1"
    else
      user_vote.first.value = 1
      flash[:notice] = "First vote"
    end

    unless @upvote.save
      flash[:notice] = "Something went wrong."
    end
    redirect_to sitcom
  end
end


#
# if vote.new == nil, increment by 1
#   if current_user == view.user_id
#     && value is 1, decrement to 0
#     && value is 0, increment to 1
