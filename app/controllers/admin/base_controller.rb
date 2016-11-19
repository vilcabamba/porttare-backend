module Admin
  class BaseController < ::ApplicationController
    before_action :authenticate_admin!
    before_action :authorize_resource

    layout "admin"

    alias_method :pundit_user, :current_admin

    # help airbrake identify current user
    alias_method :current_member, :current_admin
    # and expose it to views so it's accessible
    helper_method :current_member

    # strict pundit
    after_action :verify_authorized
    after_action :verify_policy_scoped

    protected

    def t(key)
      I18n.t(key)
    end

    private

    def authorize_resource; raise NotImplementedError; end
  end
end
