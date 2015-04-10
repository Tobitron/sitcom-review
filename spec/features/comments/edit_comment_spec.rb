require 'rails_helper'

feature 'Feature: edit a comment.' do
  context 'As an authenticated user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    scenario 'edit own comment successfully' do
      review = FactoryGirl.create(:review)
      comment = FactoryGirl.create(:comment, review: review, user: user)
      visit edit_review_comment_path(review, comment)
      fill_in 'Body', with: 'I hate your review.'
      click_button 'Update Comment'
      expect(page).to have_content('Your comment was updated!')
    end

    scenario 'fail to edit own comment due to invalid input' do
      review = FactoryGirl.create(:review)
      comment = FactoryGirl.create(:comment, review: review, user: user)
      visit edit_review_comment_path(review, comment)
      fill_in 'Body', with: ''
      click_button 'Update Comment'
      expect(page).to have_content("Comment can't be blank.")
    end

    scenario "can't edit a comment you didn't create" do
      review = FactoryGirl.create(:review)
      FactoryGirl.create(:comment, review: review)
      visit sitcom_path(review.sitcom)
      within(:css, ".comment") do
        expect(page).to_not have_content("Delete")
      end
    end
  end
end
