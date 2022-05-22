module Admins
  class KudosController < BaseController
    def index
      @kudos = Kudo.all.includes(:giver, :reciever).order('created_at DESC')
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      authorize!
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
