require 'rails_helper'

feature 'Feature: create an admin.' do
  context 'As an admin' do
    scenario 'create a new sitcom' do
      admin = FactoryGirl.create(:user, role: "admin")
      sign_in_as admin
      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_path
      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'
      click_on 'Create Sitcom'
      expect(page).to have_content('The Simpsons')
      expect(page).to have_content('this is a description for the simpsons')
      expect(page).to have_content('1995')
      expect(page).to have_content('Cartoon Comedy')
      expect(page).to have_content('Fox')
    end

    scenario 'edit a sitcom' do
      admin = FactoryGirl.create(:user, role: "admin")
      user = FactoryGirl.create(:user)
      sign_in_as user
      visit new_sitcom_path
      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'
      click_on 'Create Sitcom'
      sign_out_as user
      sign_in_as admin
      click_on "The Simpsons"
      click_on 'Edit'
      select 2000, from: 'sitcom_end_year'
      click_on 'Update Sitcom'

      expect(page).to have_content('2000')
    end

    scenario 'delete a sitcom' do
      admin = FactoryGirl.create(:user, role: "admin")
      user = FactoryGirl.create(:user)
      sign_in_as user
      visit new_sitcom_path
      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'
      click_on 'Create Sitcom'
      sign_out_as user
      sign_in_as admin
      click_on "The Simpsons"
      click_on 'Delete'
      expect(page).to have_content("Sitcom Deleted")
    end

    scenario 'I can successfully update a review' do
      review = FactoryGirl.create(:review)
      admin = FactoryGirl.create(:user, role: "admin")
      sign_in_as admin
      visit edit_sitcom_review_path(review.sitcom, review)
      fill_in 'Body', with: 'I really like show so much that I edited it.'
      select(5, from: 'Rating')
      click_on 'Update Review'
      expect(page).to have_content("Review updated!")
    end

    scenario 'I can successfully delete a review' do
      review = FactoryGirl.create(:review)
      admin = FactoryGirl.create(:user, role: "admin")
      sign_in_as admin
      visit sitcom_path(review.sitcom)
      within(:css, "ul.reviews") do
        click_on "Delete"
      end
      expect(page).to have_content("Review deleted")
    end
  end
end
