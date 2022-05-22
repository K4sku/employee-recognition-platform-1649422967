module Admins
  class PagesController < ApplicationController
    before_action :authenticate_admin!
    # GET admins/pages/dashboard
    def dashboard
      @kudos = Kudo.includes(:giver, :reciever).all.order('id DESC')
    end

    # DELETE admins/pages/dashboard/kudo/(:id)
    def destroy_kudo
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      flash[:notice] = 'Kudo was successfully destroyed.'
      redirect_to admins_pages_dashboard_path
    end

    private

    def authorize!
      raise AuthorizationError unless admin_signed_in?
    end
  end
end
