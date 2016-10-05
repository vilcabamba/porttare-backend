# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  info                   :json
#  credentials            :json
#  tokens                 :json
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "email validation depending on social network" do
    let(:user_from_facebook) { create :user, provider: 'facebook', uid: 213123 }
    let(:user_from_twitter) { create :user, provider: 'twitter', uid: 211123 }

    describe "twitter is allowed without email" do
      it {
        subject.email = nil
        expect(user_from_twitter).to be_valid
      }
    end

    describe "should not allow from others without email" do
      it {
        user_from_facebook.email = nil
        expect(user_from_facebook).to_not be_valid
      }
    end
  end
end
