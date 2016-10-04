require "rails_helper"

RSpec.describe Api::Provider,
               type: :request do
  describe "user authentication social networks" do
    let(:user_from_facebook) { create :user, provider: 'facebook', uid: 213123 }
    let(:user_from_twitter) { create :user, provider: 'twitter', uid: 211123 }

    describe "should validate email" do
      it {
        user_from_twitter.email = nil
        expect(user_from_twitter).to be_valid
      }

      it {
        user_from_facebook.email = nil
        expect(user_from_facebook).to_not be_valid
      }
    end
  end
end
