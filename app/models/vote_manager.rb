class VoteManager
  attr_reader :user, :review, :vote

  def initialize(user, review, vote)
    @user = user
    @review = review
    @vote = vote
  end

  def upvote
    unless @user.votes.where(review: @review).length > 1
      user_vote = @user.user_vote_by_review(@review)

      if user_vote == nil
        @vote.first_upvote
      elsif user_vote.is_upvote?
        user_vote.to_neutral
      else user_vote.is_neutral? || user_vote.is_downvote?
        user_vote.to_upvote
      end
    end
  end

  def downvote
    unless @user.votes.where(review: @review).length > 1
      user_vote = @user.user_vote_by_review(@review)

      if user_vote == nil
        @vote.first_downvote
      elsif user_vote.is_downvote?
        user_vote.to_neutral
      else user_vote.is_neutral? || user_vote.is_upvote?
        user_vote.to_downvote
      end
    end
  end
end
