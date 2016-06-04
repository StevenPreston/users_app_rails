require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    subject { FactoryGirl.build(:user, password: nil) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
