class ProviderProfilePolicy < ApplicationPolicy
  def create?
    # if the user doesn't have a provider profile already
    user.provider_profile.nil?
  end
end
