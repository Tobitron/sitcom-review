require 'rails-helper'

feature 'any visitor searches' do

  scenario 'visitor searches from anywhere on site' do
    sitcom1 = FactoryGirl.create(:sitcom)
    sitcom2 = FactoryGirl.create(:sitcom)

    visit sitcoms_path

    fill_in 'sitcom_name', with: 'The Simpsons'
    fill_in 'sitcom_description', with: 'description for the simpsons'
    select 1995, from: 'sitcom_start_year'
    fill_in 'sitcom_genre', with: 'Cartoon Comedy'
    fill_in 'sitcom_network', with: 'Fox'

    click_on 'Create Sitcom'
    click_on 'Edit'
    fill_in 'sitcom_description', with: 'NEW DESCRIPTION FOR THE SIMPSONS'
    click_on 'Update Sitcom'

    expect(page).to have_content('NEW DESCRIPTION FOR THE SIMPSONS')
  end

end
