module Admins
  class PagesController < ApplicationController
    before_action :authenticate_admin!
    def dashboard
      # GET /kudos
      @kudos = Kudo.all.order('id DESC')
    end

    def destroy_kudo
      # DELETE /kudos/1
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      @kudo.giver.increment(:number_of_available_kudos).save
      flash[:notice] = 'Kudo was successfully destroyed.'
      redirect_to admins_pages_dashboard_path
    end

    private

    def authorize!
      raise AuthorizationError unless admin_signed_in?
    end
  end
end
