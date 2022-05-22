module Admins
  class KudosController < BaseController
    def index
      @kudos = Kudo.includes(:giver, :reciever).all.order('id DESC')
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      flash[:notice] = 'Kudo was successfully destroyed.'
      redirect_to admins_kudos_path
    end

    private

    def authorize!
      raise AuthorizationError unless admin_signed_in?
    end
  end
end
