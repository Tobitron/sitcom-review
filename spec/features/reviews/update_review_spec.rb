require 'rails_helper'

feature 'Feature: updating reviews' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'I can successfully update a review', js:true do
      review = FactoryGirl.create(:review, user: user)
      visit edit_review_path(review)
      fill_in 'Body', with: "I've changed my mind about this show."
      find(:xpath, "//img[@alt='4']").click
      click_on 'Update Review'
      expect(page).to have_content("Review updated!")
    end

    scenario 'I can\'t update a review I didn\'t write if I\'m not an admin', js:true do
      review = FactoryGirl.create(:review)
      visit edit_review_path(review)
      expect(page).to_not have_content("Update Review")
    end
  end
end
