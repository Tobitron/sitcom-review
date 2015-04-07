require 'rails_helper'

feature 'Feature: create a review.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user, role: "admin") }

    before :each do
      sign_in_as user
    end

    scenario "create a new review for a sitcom" do

      sitcom = FactoryGirl.create(:sitcom)
      visit new_sitcom_review_path(sitcom)

      fill_in 'Body', with: 'This is the most amazing show ever created.'
      select(5, from: 'Rating')
      click_button 'Create Review'

      expect(page).to have_content('Successfully created your review.')
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
