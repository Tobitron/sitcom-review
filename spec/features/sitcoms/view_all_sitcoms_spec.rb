require 'rails_helper'

feature 'any user views a list of all sitcoms' do
  context 'as a visitor' do

    scenario 'visitor views a list of all sitcoms' do
      FactoryGirl.create(:sitcom)
      FactoryGirl.create(:sitcom)
      FactoryGirl.create(:sitcom)

      visit sitcoms_path
      save_and_open_page
      expect(page).to have_content("Futurama")
    end
  end
end
