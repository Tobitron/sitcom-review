require 'rails_helper'

describe VoteManager do
    let(:vote_manager) { VoteManager.new(user, review) }
    let(:user) { FactoryGirl.create(:user) }
    let(:review) { FactoryGirl.create(:review) }

  describe "#upvote" do

    context "user has no vote" do
      it "creates a vote with value 1" do
        vote_manager.upvote
        expect(user.votes.first.value).to eq 1
      end
    end

    context "user has made a upvote" do
      it "updates a vote to value 0" do
        FactoryGirl.create(:upvote, user: user, review: review)
        expect(user.votes.first.value).to eq 1
        vote_manager.upvote
        expect(user.votes.first.value).to eq 0
      end
    end

    context "user has made a downvote" do
      it "updates a vote to value 1" do
        FactoryGirl.create(:downvote, user: user, review: review)
        expect(user.votes.first.value).to eq -1
        vote_manager.upvote
        expect(user.votes.first.value).to eq 1
      end
    end
  end

  describe "#downvote" do

    context "user has no vote" do
      it "updates a vote with value -1" do
        vote_manager.downvote
        expect(user.votes.first.value).to eq -1
      end
    end

    context "user has made a upvote" do
      it "updates a vote with value -1" do
        FactoryGirl.create(:upvote, user: user, review: review)
        expect(user.votes.first.value).to eq 1
        vote_manager.downvote
        expect(user.votes.first.value).to eq -1
      end
    end

    context "user has made a downvote" do
      it "updates a vote to value 0" do
        FactoryGirl.create(:downvote, user: user, review: review)
        expect(user.votes.first.value).to eq -1
        vote_manager.downvote
        expect(user.votes.first.value).to eq 0
      end
    end
  end
end
