module Admin
  class ProvidersController < BaseController
    before_action :find_provider_profile,
                  except: :index

    def index
      @provider_status = params[:status] || ProviderProfile.status.values.first
      @provider_profiles = providers_scope.with_status(
        @provider_status
      ).decorate
    end

    def show
      @provider_status = @provider_profile.status
    end

    def transition
      @provider_profile.paper_trail_event = params[:predicate]
      @provider_profile.update!(status: params[:predicate])
      redirect_to action: :show, id: params[:id]
    end

    private

    def find_provider_profile
      @provider_profile = providers_scope.find(params[:id]).decorate
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
      Admin::ProviderProfilePolicy.new(
        pundit_user,
        ProviderProfile
      )
    end
    helper_method :pundit_policy

    def providers_scope
      skip_policy_scope
      Admin::ProviderProfilePolicy::Scope.new(
        pundit_user,
        ProviderProfile
      ).resolve
    end
  end
end
