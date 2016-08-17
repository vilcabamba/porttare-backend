class User < ActiveRecord::Base
  module Serializable
    extend ActiveSupport::Concern

    def token_validation_response
      super.merge(mandatory_associations)
    end

    private

    def mandatory_associations
      [
        :provider_profile
      ].inject({}) do |memo, association|
        memo["#{association}_id"] = send(association).try :id
        memo
      end
    end
  end
end
