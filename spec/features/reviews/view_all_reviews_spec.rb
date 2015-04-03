require 'rails_helper'

feature 'viewing all the reviews for a sitcom' do
  context 'as any user' do
    scenario 'user sees all reviews for a sitcom on its detail page' do
      sitcom = FactoryGirl.create(:sitcom)
      FactoryGirl.create(:review, sitcom: sitcom)
      FactoryGirl.create(:review, sitcom: sitcom, body: "My awesome review")

      visit sitcom_path(sitcom)
      expect(page).to have_content("My awesome review")
      expect(page).to have_content("This show is soooooo gooood.")
    end
  end
end
