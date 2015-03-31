require 'rails_helper'

feature 'Feature: create a review.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'create a new review' do
      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_review_path(sitcom)
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      select(5, :from => 'Rating')
      click_button 'Create Review'

      expect(page).to have_content('Successfully created your review.')
    end

    scenario 'fail to create a review due to invalid input' do
      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_review_path(sitcom)
      click_button 'Create Review'
      expect(page).to have_content("Rating is not a number")
    end

    scenario 'fail to create a duplicate review' do
      sitcom = FactoryGirl.create(:sitcom)
      Review.create(body: "This is the most amazing show ever created.", user_id: user.id, sitcom_id: sitcom.id, rating: 5)
      visit new_sitcom_review_path(sitcom)
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      select('5', :from => 'Rating')
      click_button 'Create Review'
      expect(page).to have_content("You have already reviewed this show.")
    end

    scenario 'See all reviews on the sitcom show page' do
      review = FactoryGirl.create(:review)
      visit sitcom_path(review.sitcom)
      expect(page).to have_content("This show is soooooo gooood.")
    end

  end
end
