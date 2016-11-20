module Admin
  class BaseController < ::ApplicationController
    module Resourceable
      extend ActiveSupport::Concern

      included do
        helper_method :pundit_policy
        cattr_accessor :resource_klass
      end

      def show
        find_current_resource
        @resource_status = @current_resource.status
      end

      private

      def find_current_resource
        @current_resource = resource_scope.find(params[:id]).decorate
      end

      def resource_scope
        skip_policy_scope
        pundit_policy_class::Scope.new(
          pundit_user,
          resource_klass
        ).resolve
      end

      def authorize_resource
        arguments = [ "#{action_name}?" ]
        arguments << params[:predicate] if params[:predicate].present?
        if pundit_policy.send(*arguments)
          skip_authorization
        else
          raise NotAuthorizedError
        end
      end

      def pundit_policy
        pundit_policy_class.new(pundit_user, self.resource_klass)
      end

      def pundit_policy_class
        "Admin::#{resource_klass}Policy".constantize
      end
    end
  end
end
