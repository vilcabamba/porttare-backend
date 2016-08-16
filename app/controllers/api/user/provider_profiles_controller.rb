module Api
  module User
    class ProviderProfilesController < BaseController

      api :POST,
          "/user/provider_profile",
          "Submit a provider profile application"
      # TODO
      # write down parameters for application
      def create
        binding.pry
        if true
          status = :created
        else
          status = :unprocessable_entity
        end
        render nothing: true, status: status
      end
    end
  end
end
