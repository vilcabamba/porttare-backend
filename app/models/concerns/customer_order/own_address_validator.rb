class CustomerOrder < ActiveRecord::Base
  class OwnAddressValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      customer_profile = record.send(:customer_profile)
      if value.present? && value.customer_profile != customer_profile
        record.errors.add("#{attribute}_id", :invalid)
      end
    end
  end
end
