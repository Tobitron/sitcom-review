require 'rails_helper'

feature 'Feature: create an admin.' do
  context 'As an admin' do

    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:user, role: "admin") }

    scenario 'create a new sitcom' do
      sign_in_as admin
      sitcom = FactoryGirl.create(:sitcom, user: admin)
      visit sitcom_path(sitcom)
      expect(page).to have_content('The funniest show since The Simpsons')
    end

    scenario 'edit a sitcom' do
      sign_in_as user
      sitcom = FactoryGirl.create(:sitcom, user: user)
      sign_out_as user
      sign_in_as admin
      visit edit_sitcom_path(sitcom)
      select 2000, from: 'sitcom_end_year'
      click_on 'Update Sitcom'

      expect(page).to have_content('2000')
    end

    scenario 'delete a sitcom' do
      sitcom = FactoryGirl.create(:sitcom, user: user)
      sign_in_as admin
      visit sitcom_path(sitcom)
      click_on 'Delete'
      expect(page).to have_content("Sitcom Deleted")
    end

    scenario 'I can successfully update a review', js:true do
      review = FactoryGirl.create(:review)
      sign_in_as admin
      visit edit_sitcom_review_path(review.sitcom, review)
      fill_in 'Body', with: 'I really like this show so much that I edited it.'
      find(:xpath, "//img[@alt='2']").click
      click_on 'Update Review'
      expect(page).to have_content("Review updated!")
    end

    scenario 'I can successfully delete a review' do
      review = FactoryGirl.create(:review)
      sign_in_as admin
      visit sitcom_path(review.sitcom)
      within(:css, ".review") do
        click_on "Delete"
      end
      expect(page).to have_content("Review deleted")
    end
  end
end
