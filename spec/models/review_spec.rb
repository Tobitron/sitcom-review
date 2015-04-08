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
end
