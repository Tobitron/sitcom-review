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
      fill_in 'sitcom_description', with: 'description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'

      click_on 'Create Sitcom'
      click_on 'Delete'

      expect(page).to_not have_content('The Simpsons')
    end

    scenario 'user cannot delete if not signed in' do
      visit new_sitcom_path
      sitcom = FactoryGirl.create(:sitcom, user: user)
      sign_out_as user
      visit sitcom_path(sitcom)

      expect(page).to_not have_content('Delete')
    end
  end
end
