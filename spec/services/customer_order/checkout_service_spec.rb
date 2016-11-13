require 'rails_helper'

describe CustomerOrder::CheckoutService,
         type: :model do
  let(:checkout_attributes) { {} }
  let(:customer_order) { create :customer_order }
  let(:user) { customer_order.customer_profile.user }

  subject {
    described_class.new(
      user,
      customer_order,
      checkout_attributes
    )
  }

  describe "invalid" do
    describe "without customer / billing address" do
      it {
        is_expected.to_not be_valid
        expect(
          subject.errors.messages
        ).to have_key(:delivery_method)
        expect(
          subject.errors.messages
        ).to have_key(:customer_address_id)
        expect(
          subject.errors.messages
        ).to have_key(:customer_billing_address_id)
      }
    end

    describe "submitted order" do
      let(:customer_order) { create :customer_order, :submitted }
      it {
        is_expected.to_not be_valid
        expect(subject.errors).to have_key(:status)
      }
    end

    describe "another user's order" do
      let(:user) { create :user, :customer }
      it {
        is_expected.to_not be_valid
        expect(subject.errors).to have_key(:status)
      }
    end
  end

  describe "delivery_method" do
    describe "shipping" do
      let(:checkout_attributes) {
        {
          delivery_method: "shipping"
        }
      }
    end

    describe "pickup" do

    end
  end
end
