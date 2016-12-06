require 'rails_helper'

RSpec.describe User,
               type: :model do
  describe "factory" do
    subject { build :user }
    it { is_expected.to be_valid }
  end

  describe "email validation" do
    describe "email provider" do
      subject { create :user, provider: "email" }

      it {
        subject.email = ""
        is_expected.to_not be_valid
      }

      it {
        existing_user = create :user, provider: "email"
        subject.email = existing_user.email
        is_expected.to_not be_valid
      }
    end

    describe "non-email provider" do
      subject { build :user, uid: "UN1QUE", provider: "twitter", email: nil }
      it { is_expected.to be_valid }
    end
  end
end
