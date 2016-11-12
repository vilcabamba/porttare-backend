module Api
  class BaseController < ::ApplicationController
    module Resourceable
      extend ActiveSupport::Concern

      included do
        cattr_accessor :resource_klass
      end

      def create
        new_api_resource
        if @api_resource.save
          render resource_identifier, status: :created
        else
          render "api/shared/resource_error",
                 status: :unprocessable_entity
        end
      end

      protected

      def new_api_resource
        @api_resource = resource_scope.new(resource_params)
      end

      def resource_scope
        policy_scope(resource_klass)
      end

      def resource_params
        params.permit(
          *policy(resource_klass).permitted_attributes
        )
      end

      def resource_identifier
        resource_klass.to_s.underscore.to_sym
      end

      def pundit_authorize
        authorize(resource_klass)
      end
    end
  end
end
