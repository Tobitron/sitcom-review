require 'rails_helper'

feature 'any visitor searches' do

  scenario 'visitor searches from anywhere on site' do
    FactoryGirl.create(:sitcom)
    FactoryGirl.create(:sitcom)
    FactoryGirl.create(:sitcom, name: "Scrubs")

    visit sitcoms_path

    fill_in 'search', with: "futur"
    click_on 'Search'

    expect(page).to have_content('Futurama')
    expect(page).to_not have_content('Scrubs')
  end

end
