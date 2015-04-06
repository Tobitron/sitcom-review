require 'rails_helper'

feature 'Feature: create a review.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user, role: "admin") }

    before :each do
      sign_in_as user
    end

    scenario 'create a new review', js:true do
      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_review_path(sitcom)
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      find(:xpath, "//img[@alt='4']").click
      click_button 'Create Review'

      expect(page).to have_content('Successfully created your review.')
    end

    scenario 'fail to create a review due to invalid input', js:true do
      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_review_path(sitcom)
      click_button 'Create Review'
      expect(page).to have_content("Rating is not a number")
    end

    scenario 'fail to create a duplicate review', js:true do
      sitcom = FactoryGirl.create(:sitcom)
      Review.create(body: "This is the most amazing show ever created.",
                    user_id: user.id, sitcom_id: sitcom.id, rating: 5)

      visit new_sitcom_review_path(sitcom)
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      find(:xpath, "//img[@alt='4']").click
      click_button 'Create Review'
      expect(page).to have_content("You have already reviewed this show.")
    end
  end
end
