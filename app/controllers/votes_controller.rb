class VotesController < ApplicationController
  before_action :fetch_review

  def create_upvote
    upvote = @review.upvotes.build
    upvote.user = current_user

    if upvote.save
      redirect_to sitcoms_path
    end
  end

  def create_downvote
    downvote = @review.downvotes.build
    downvote.user = current_user

    if downvote.save
      redirect_to sitcoms_path
    end
  end

  private

  def fetch_review
    @review = Review.find(params[:id])
  end
end

