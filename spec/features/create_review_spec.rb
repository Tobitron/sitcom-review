require 'rails_helper'

feature 'create a review' do
  context 'as an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'create a new review' do
      #tv_show = FactoryGirl.create(:tv_show)
      #visit tv_show_path(tv_show)

      visit new_review_path
      fill_in 'Body', with: 'This is the most amazing show ever created.'
      select('5', :from => 'Rating')
      click_button 'Create Review'

      expect(page).to have_content('Successfully added your review.')
    end

    scenario 'fail to create a review due to invalid input' do
      #tv_show = FactoryGirl.create(:tv_show)
      #visit tv_show_path(tv_show)

      visit new_review_path
      click_button 'Create Review'
      expect(page).to have_content("Rating can't be blank.")
    end

    pending 'fail to create a duplicate review' do
      #tv_show = FactoryGirl.create(:tv_show)
      #visit tv_show_path(tv_show)

      #fill_in 'Body', with: 'This is the most amazing show ever created.'
      #select('5', :from => 'Rating')
      #click_button 'Create Review'
    end
  end
end
