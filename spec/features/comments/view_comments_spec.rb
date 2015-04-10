require 'rails_helper'

feature 'Feature: view all comments.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'See all comments on the sitcom show page' do
      review = FactoryGirl.create(:review)
      FactoryGirl.create(:comment, body: "I hate your review", user: user, review: review)
      FactoryGirl.create(:comment, body: "I love your review", user: user, review: review)      
      visit sitcom_path(review.sitcom)
      expect(page).to have_content("I hate your review")
      expect(page).to have_content("I love your review")
    end
  end
end
