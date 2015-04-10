require 'rails_helper'

feature 'Feature: deleting comments' do
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in_as user
  end

  context 'as an authorized user' do
    scenario 'I can successfully delete my own comment' do
      review = FactoryGirl.create(:review)
      FactoryGirl.create(:comment, review: review, user: user)
      visit sitcom_path(review.sitcom)
      within(:css, ".comment") do
        click_on "Delete"
      end
      expect(page).to have_content("Comment deleted")
    end

    scenario "I can't delete a comment I didn't write since I'm not an admin" do
      review = FactoryGirl.create(:review)
      FactoryGirl.create(:comment, review: review)
      visit sitcom_path(review.sitcom)
      within(:css, ".comment") do
        expect(page).to_not have_content("Delete")
      end
    end
  end
end
