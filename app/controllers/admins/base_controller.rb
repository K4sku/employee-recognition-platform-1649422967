module Admins
  class BaseController < ApplicationController
    before_action :authenticate_admin!
    def pundit_user
      current_admin
    end

    def authorize(record, query = nil)
      super([:admins, record], query)
    end
  end
end
