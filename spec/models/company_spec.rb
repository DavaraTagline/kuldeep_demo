require 'rails_helper'

RSpec.describe Company, type: :model do
  subject {Company.new(name: 'test', email: 'test@gmail.com', website: 'https://www.sample.com')}

  before { subject.save }

  context "validation test" do
    it "should not valid if name is not present" do
      subject.name = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end

    it "should not valid if email is not present" do
      subject.email = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end

    it "should not valid if webiste is not present" do
      subject.website = nil
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to include("Website can't be blank")
    end
  end

  describe "Associations" do
    it { should have_many(:users).through(:departments) }
  end
end