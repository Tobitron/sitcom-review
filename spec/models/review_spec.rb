require 'rails_helper'

describe "Review" do

  let(:vote_manager) { VoteManager.new(user, review) }
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review) }

  describe "#user_upvoted?" do
    context "logged in user upvotes a reivew" do
      it "user upvoted method returns true" do
        vote_manager.upvote
        expect(review.user_upvoted?(user)).to eq true
      end
    end
  end
  describe "#down_voted?" do
    context "logged in user downvotes a reivew" do
      it "user downvoted method returns true" do
        vote_manager.downvote
        expect(review.user_downvoted?(user)).to eq true
      end
    end
  end
end
