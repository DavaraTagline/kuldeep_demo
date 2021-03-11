require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { create(:company) }

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }  
    it { is_expected.to validate_presence_of(:email) }  
    it { is_expected.to validate_presence_of(:website) }  
  end

  describe "Associations" do
    it { should have_many(:users).through(:departments) }
  end
end