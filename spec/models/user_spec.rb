require 'rails_helper'

RSpec.describe User, type: :model do
  subject {User.new(name: "test", email: 'test@gmail.com', phone:'123456789',gender:'male',password: '12345678')}

  before { subject.save }

  context "validation test" do
    it "should be present name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end
    
    context "Email validation" do
      it "should be present email" do
        subject.email = nil
        expect(subject).not_to be_valid
      end

      it "should be valid email" do
        subject.email = "test@gmail.com"
        expect(subject).to be_valid
      end

      it "should not valid if email is not in proper format" do
        subject.email = "abc"
        expect(subject).not_to be_valid
      end 
    end
    
    it "should be present phone number" do
      subject.phone = nil
      expect(subject).not_to be_valid
    end
    
    it "should be present gender" do
      subject.gender = nil
      expect(subject).not_to be_valid
    end

  end
end