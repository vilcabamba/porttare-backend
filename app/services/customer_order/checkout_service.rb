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
      validate_customer_order &&
        validate_required_attributes &&
        assign_submission_attributes
    end

    private

    def assign_submission_attributes
      @customer_order.assign_attributes(@submission_attributes)
      @customer_order.valid?
    rescue ArgumentError => e
      errors.add(:base, e.message)
      false
    end

    def validate_customer_order
      unless CustomerOrderPolicy.new(@user, @customer_order).checkout?
        errors.add(:status, :invalid)
      end
      errors.empty?
    end

    def validate_required_attributes
      required_attributes.each do |required_attribute|
        if @submission_attributes[required_attribute].blank?
          errors.add(required_attribute, :blank)
        end
      end
      errors.empty?
    end

    def required_attributes
      attributes = [
        :forma_de_pago,
        :delivery_method,
        :customer_billing_address_id
      ]
      if @submission_attributes[:delivery_method] != "pickup"
        attributes << :customer_address_id
      end
      attributes
    end
  end
end
