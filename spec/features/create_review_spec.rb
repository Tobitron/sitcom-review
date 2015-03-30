require 'rails_helper'

feature 'Feature: create a review.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'create a new review' do
      #sitcom = FactoryGirl.create(:sitcom)
      #visit sitcom_path(sitcom)

      visit new_review_path
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      select('5', :from => 'Rating')
      click_button 'Create Review'

      expect(page).to have_content('Successfully created your review.')
    end

    scenario 'Fail to create a review due to invalid input' do
      #sitcom = FactoryGirl.create(:sitcom)
      #visit sitcom_path(sitcom)

      visit new_review_path
      click_button 'Create Review'
      expect(page).to have_content("Rating is not a number")
    end

    pending 'Fail to create a duplicate review'
      #sitcom = FactoryGirl.create(:sitcom)
      #visit sitcom_path(sitcom)

      #fill_in 'Body', with: 'This is the most amazing show ever created.'
      #select('5', :from => 'Rating')
      #click_button 'Create Review'
  end
end
