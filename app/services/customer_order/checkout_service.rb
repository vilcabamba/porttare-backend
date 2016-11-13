class CustomerOrder < ActiveRecord::Base
  ##
  # to submit customer orders
  class CheckoutService
    delegate :errors, to: :@customer_order

    def initialize(user, customer_order, submission_attributes)
      @user = user
      @customer_order = customer_order
      @submission_attributes = submission_attributes
    end

    def valid?
      validate_customer_order && validate_required_attributes
    end

    private

    def validate_customer_order
      unless CustomerOrderPolicy.new(@user, @customer_order).checkout?
        errors.add(:status, :invalid)
      end
      errors.empty?
    end

    def validate_required_attributes
      [
        :delivery_method,
        :customer_address_id,
        :customer_billing_address_id
      ].each do |required_attribute|
        if @submission_attributes[required_attribute].blank?
          errors.add(required_attribute, :blank)
        end
      end
      errors.empty?
    end
  end
end
