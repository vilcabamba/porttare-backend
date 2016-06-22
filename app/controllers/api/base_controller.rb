module Api
  class BaseController < ::ApplicationController
    include JsonRequestsForgeryBypass
    include DeviseTokenAuth::Concerns::SetUserByToken
  end
end
