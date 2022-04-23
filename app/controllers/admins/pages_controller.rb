module Admins
  class PagesController < ApplicationController
    before_action :authenticate_admin!
    def dashboard
      # GET /kudos
      @kudos = Kudo.all.order('id DESC')
    end
  end

  private

  def authorize!
    raise AuthorizationError unless admin_signed_in?
  end
end
