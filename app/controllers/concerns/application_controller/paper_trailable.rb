class ApplicationController < ActionController::Base
  module PaperTrailable
    extend ActiveSupport::Concern

    included do
      before_action :set_paper_trail_whodunnit
    end

    protected

    def user_for_paper_trail
      pundit_user.id # honour pundit
    end
  end
end
