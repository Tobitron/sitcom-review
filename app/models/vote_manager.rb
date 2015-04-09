class VoteManager
  attr_reader :user, :review, :vote

  def initialize(user, review)
    @user = user
    @review = review
    @vote = find_or_new_vote
  end

  def upvote
    return if multiple_votes?
    vote.upvote
  end

  def downvote
    return if multiple_votes?
    vote.downvote
  end

  private

  def find_or_new_vote
    existing_vote.present? ? existing_vote : user.votes.new(review: review, value: 0)
  end

  def existing_vote
    user.votes.find_by(review: review)
  end

  def multiple_votes?
    user.votes.where(review: review).length > 1
  end
end
