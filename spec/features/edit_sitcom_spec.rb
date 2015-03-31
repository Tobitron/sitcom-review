require 'rails_helper'

feature 'user edits sitcom' do

  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'user edits a sitcom they submitted' do
      visit new_sitcom_path

      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      select 1995, from: 'sitcom_start_year'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'

      click_on 'Create Sitcom'

      click_on 'Edit'

      fill_in 'sitcom_description', with: 'THIS IS A BRAND NEW DESCRIPTION FOR THE SIMPSONS'

      click_on 'Update Sitcom'

      expect(page).to have_content('THIS IS A BRAND NEW DESCRIPTION FOR THE SIMPSONS')
    end
  end
end
