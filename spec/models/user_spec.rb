require 'rails_helper'

RSpec.describe User, type: :model do
  subject {create(:user)}

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:gender) }
  end
  
  it "is not valid when email in not in proper format" do
    subject.email = "abc"
    expect(subject).not_to be_valid
  end
end