require 'rails_helper'

feature 'Feature: deleting reviews' do
  context 'as an authorized user' do
    scenario 'I can successfully delete a review' do
      review = FactoryGirl.create(:review)
      sign_in_as review.user
      visit sitcom_path(review.sitcom)
      within(:css, "ul.reviews") do
        click_on "Delete"
      end
      expect(page).to have_content("Review deleted")
    end
  end
end
