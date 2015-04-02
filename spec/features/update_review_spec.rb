require 'rails_helper'

feature 'Feature: updating reviews' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can successfully update a review' do
      review = FactoryGirl.create(:review)
      visit edit_sitcom_review_path(review.sitcom, review)
      fill_in 'Body', with: 'I really like show so much that I edited it.'
      select(5, from: 'Rating')
      click_on 'Update Review'
      expect(page).to have_content("Review updated!")
    end
  end
end