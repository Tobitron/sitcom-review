require 'rails_helper'

feature 'any user views a list of all sitcoms' do
  context 'as an authorized user' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as user
    end

    pending 'user views list of all sitcoms' 
  end
end
