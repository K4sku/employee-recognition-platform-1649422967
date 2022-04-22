module Admin
  class PagesController < ApplicationController
    before_action :authenticate_admin_user!
    def dashboard
      # GET /kudos
      @kudos = Kudo.all.order('id DESC')
    end
  end

  private

  def authorize!
    raise AuthorizationError unless admin_user_signed_in?
  end
end
