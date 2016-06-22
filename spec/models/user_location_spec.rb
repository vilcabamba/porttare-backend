require 'rails_helper'

RSpec.describe UserLocation,
               type: :model do
  describe "factory" do
    subject { build :user_location }
    it { is_expected.to be_valid }
  end
end
