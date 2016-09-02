module Admin
  class UsersController < BaseController
    def index
      authorize User
      @users = policy_scope(User).all
    end
  end
end
