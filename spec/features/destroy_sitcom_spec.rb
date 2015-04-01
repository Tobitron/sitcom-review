require 'rails_helper'

feature 'user deletes sitcom' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user, role: "member") }

    before :each do
      sign_in_as user
    end

    scenario 'user deletes a sitcom they submitted' do
      visit new_sitcom_path

      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'

      click_on 'Create Sitcom'

      click_on 'Delete'

      expect(page).to_not have_content('The Simpsons')
    end

    scenario 'user cannot delete if not signed in' do
      visit new_sitcom_path

      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'
      click_on 'Create Sitcom'
      click_on 'Sign Out'
      click_on 'The Simpsons'

      expect(page).to_not have_content('Delete')
    end
  end
end
