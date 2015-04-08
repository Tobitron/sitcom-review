require 'rails_helper'

feature "Voting on a review" do

  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review) }

  scenario "an authenticated user upvotes a review" do
    sign_in_as user
    FactoryGirl.create(:upvote, user: user, review: review)
    visit sitcom_path(review)

    expect(page).to have_css('.upvote')
  end

  scenario "an authenticated user upvotes a review" do
    sign_in_as user
    FactoryGirl.create(:downvote, user: user, review: review)
    visit sitcom_path(review)

    expect(page).to have_css('.downvote')
  end
end
