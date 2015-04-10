require 'rails_helper'

feature 'any user views a list of all sitcoms with pagination' do

  scenario 'I view paginated sitcoms' do
    FactoryGirl.create(:sitcom, name: 'Archer', start_year: 2015)
    FactoryGirl.create_list(:sitcom, 25)

    visit root_path
    expect(page).to have_content('Archer')
  end

  scenario 'I view paginated sitcoms page 2' do
    FactoryGirl.create_list(:sitcom, 25)
    FactoryGirl.create(:sitcom, name: 'Archer')

    visit root_path
    click_on 'Next'

    expect(page).to have_content('Archer')
  end
end
