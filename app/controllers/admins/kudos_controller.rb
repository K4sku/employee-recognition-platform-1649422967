module Admins
  class KudosController < BaseController
    def index
      @kudos = Kudo.all.includes(:giver, :reciever).order('created_at DESC')
    end

    def destroy
      @kudo = Kudo.find(params[:id])
      @kudo.destroy
      flash[:notice] = 'Kudo was successfully destroyed.'
      redirect_to admins_kudos_path
    end
  end
end
