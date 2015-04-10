require 'rails_helper'

describe SitcomManager do
    let!(:mash) { FactoryGirl.create(:sitcom, name: "MASH", start_year: 1970) }
    let!(:scrubs) { FactoryGirl.create(:sitcom, name: "Scrubs", start_year: 2001) }
    let!(:friends) { FactoryGirl.create(:sitcom, name: "Friends", start_year: 1994) }

    let!(:review1) { FactoryGirl.create(:review, sitcom_id: scrubs.id, rating: 5) }
    let!(:review2) { FactoryGirl.create(:review, sitcom_id: friends.id, rating: 2) }
    let!(:review3) { FactoryGirl.create(:review, sitcom_id: friends.id, rating: 4) }
    let!(:review4) { FactoryGirl.create(:review, sitcom_id: mash.id, rating: 4) }
    let(:sitcom_manager_without_search) { SitcomManager.new(nil, 1) }
    let(:sitcom_manager_with_search) { SitcomManager.new("r", 1) }

  describe "#newest_sitcoms" do

    context "user sees sitcoms with most recent starting year first" do
      it "creates sitcoms with different starting years" do
        expect(sitcom_manager_without_search.newest_sitcoms[0].name).to eq "Scrubs"
        expect(sitcom_manager_without_search.newest_sitcoms[1].name).to eq "Friends"
        expect(sitcom_manager_without_search.newest_sitcoms[2].name).to eq "MASH"
      end
    end

    context "user sees sitcoms with the highest rating first" do
      it "creates sitcoms with different ratings" do
        expect(sitcom_manager_without_search.highest_rated[0].name).to eq "Scrubs"
        expect(sitcom_manager_without_search.highest_rated[1].name).to eq "MASH"
        expect(sitcom_manager_without_search.highest_rated[2].name).to eq "Friends"
      end
    end

    context "user sees sitcoms with the most reviews first" do
      it "creates sitcoms with different numbers of reviews" do
        expect(sitcom_manager_without_search.most_reviewed[0].name).to eq "Friends"
        expect(sitcom_manager_without_search.most_reviewed[1].name).to eq "Scrubs"
        expect(sitcom_manager_without_search.most_reviewed[2].name).to eq "MASH"
      end
    end

    context "user sees sitcoms that fill the search criteria and with most recent starting year first" do
      it "creates sitcoms with different starting years & search 'r'" do
        expect(sitcom_manager_with_search.newest_sitcoms[0].name).to eq "Scrubs"
        expect(sitcom_manager_with_search.newest_sitcoms[1].name).to eq "Friends"
      end
    end

    context "user sees sitcoms that fill the search criteria and with the highest rating first" do
      it "creates sitcoms with different ratings & search 'r'" do
        expect(sitcom_manager_with_search.highest_rated[0].name).to eq "Scrubs"
        expect(sitcom_manager_with_search.highest_rated[1].name).to eq "Friends"
      end
    end

    context "user sees sitcoms that fill the search criteria and with the most reviews first" do
      it "creates sitcoms with different numbers of reviews & search 'r'" do
        expect(sitcom_manager_with_search.most_reviewed[0].name).to eq "Friends"
        expect(sitcom_manager_with_search.most_reviewed[1].name).to eq "Scrubs"
      end
    end
  end
end
