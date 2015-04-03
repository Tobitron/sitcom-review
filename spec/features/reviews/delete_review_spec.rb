require 'rails_helper'

feature 'Feature: deleting reviews' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in_as user
  end

  context 'as an authorized user' do
    scenario 'I can successfully delete a review' do
      review = FactoryGirl.create(:review, user: user)
      visit sitcom_path(review.sitcom)
      within(:css, "ul.reviews") do
        click_on "Delete"
      end
      expect(page).to have_content("Review deleted")
    end

    scenario "I can\'t delete a review I didn\'t write since I\'m not an admin" do
      review = FactoryGirl.create(:review)
      visit sitcom_path(review.sitcom)
      within(:css, "ul.reviews") do
        expect(page).to_not have_content("Delete")
      end
    end
  end
end
