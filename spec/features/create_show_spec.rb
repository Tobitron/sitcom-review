require 'rails_helper'

feature 'user creates sitcom' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

  scenario 'user creates valid sitcom' do
      visit new_sitcom_path

      fill_in 'sitcom_name', with: 'The Simpsons'
      fill_in 'sitcom_description', with: 'this is a description for the simpsons'
      fill_in 'sitcom_start_year', with: '1995'
      fill_in 'sitcom_genre', with: 'Cartoon Comedy'
      fill_in 'sitcom_network', with: 'Fox'

      click_on 'Create Sitcom'

      expect(page).to have_content('The Simpsons')
      expect(page).to have_content('this is a description for the simpsons')
      expect(page).to have_content('1995')
      expect(page).to have_content('Cartoon Comedy')
      expect(page).to have_content('Fox')
    end
  end
end
