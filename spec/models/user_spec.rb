require 'rails_helper'

describe "#admin?" do
  it "is not an admin if the role is not admin" do
    user = FactoryGirl.create(:user, role: "member")
    expect(user.admin?).to eq(false)
  end

  it "is an admin if the role is admin" do
    user = FactoryGirl.create(:user, role: "admin")
    expect(user.admin?).to eq(true)
  end
end

describe '#owner_or_admin?' do
  let(:user) { FactoryGirl.create(:user, role: role) }
  let(:sitcom) { FactoryGirl.create(:sitcom, user: user) }

  context 'user is an admin' do
    let(:role) { "admin" }

    it 'returns true' do
      expect(sitcom.owner_or_admin?(user)).to eq true
    end
  end

  context 'user is not an admin' do
    let(:role) { "member" }

    context 'user created the sitcom' do
      it 'returns true' do
        expect(sitcom.owner_or_admin?(user)).to eq true
      end
    end

    context 'user did not create the sitcom' do
      let(:other_user) { FactoryGirl.create(:user) }

      it 'returns false' do
        expect(sitcom.owner_or_admin?(other_user)).to eq false
      end
    end
  end
end
