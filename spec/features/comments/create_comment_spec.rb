require 'rails_helper'

feature 'Feature: create a comment.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'create a new comment' do
      review = FactoryGirl.create(:review)
      visit new_review_comment_path(review)
      fill_in 'Body', with: 'I hate your review.'
      click_button 'Create Comment'
      expect(page).to have_content('Your comment was added!')
    end

    scenario 'fail to create a comment due to invalid input' do
      review = FactoryGirl.create(:review)
      visit new_review_comment_path(review)
      click_button 'Create Comment'
      expect(page).to have_content("Comment can\'t be blank.")
    end

    scenario 'See all comments on the sitcom show page' do
      review = FactoryGirl.create(:review)
      Comment.create(body: "I hate your review", user: user, review: review)
      Comment.create(body: "I love your review", user: user, review: review)
      visit sitcom_path(review.sitcom)
      expect(page).to have_content("I hate your review")
      expect(page).to have_content("I love your review")
    end
  end
end
