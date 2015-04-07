require 'rails_helper'

feature 'viewing all the reviews for a sitcom' do
  context 'as any user' do
    scenario 'user sees all reviews for a sitcom on its detail page', js:true do
      sitcom = FactoryGirl.create(:sitcom)
      FactoryGirl.create(:review, sitcom: sitcom, rating: 2)
      FactoryGirl.create(:review, sitcom: sitcom, rating: 4, body: "My awesome review")

      visit sitcom_path(sitcom)
      expect(page).to have_content("My awesome review")
      expect(page).to have_content("This show is soooooo gooood.")
      within(:css, ".avg_rating") do
        expect(page).to have_xpath("//img[@alt='3']")
      end
    end
  end
end
