require 'rails_helper'

feature 'user downvotes a review', %Q{
  As a user
  I want to downvote reviews
  So that I can help inform other visitors which reviews are worst
} do

  # Acceptance Criteria:
  # * I must be an authorized user
  # * If I have never voted my downvote is recorded
  # * If I have already downvoted my vote becomes neutral
  # * If I have already upvoted my votes becomes a downvote
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'authorized user downvotes review that they hadn\'t upvoted before' do
      review = FactoryGirl.create(:review)
      visit sitcom_path(review.sitcom)
      click_on "⬇"

      expect(page).to have_content('-1')
    end

    scenario 'authorized user upvotes review that they had upvoted before' do
      review = FactoryGirl.create(:review)
      visit sitcom_path(review.sitcom)
      click_on "⬇"
      click_on "⬇"

      expect(page).to have_content('0')
    end

    scenario 'authorized user upvotes review that they had downvoted before' do
      review = FactoryGirl.create(:review)
      visit sitcom_path(review.sitcom)
      click_on "⬆"
      click_on "⬇"

      expect(page).to have_content('-1')
    end

    scenario 'an unauthorized user attempts to upvote a review' do
      review = FactoryGirl.create(:review)

      sign_out_as user

      visit sitcom_path(review.sitcom)
      click_on "⬇"

      expect(page).to have_content('Log in')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Remember me')
    end
  end
end
