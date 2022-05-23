class KudosController < ApplicationController
  before_action :authenticate_employee!

  def index
    @kudos = Kudo.all.includes(:giver, :reciever, :company_value).order('created_at DESC')
  end

  def show
    @kudo = find_kudo
  end

  def new
    @kudo = Kudo.new
  end

  def edit
    @kudo = find_kudo
    authorize!
  end

  def create
    @kudo = Kudo.new(kudo_params)
    @kudo.giver = current_employee
    if current_employee.number_of_available_kudos <= 0
      flash.now[:alert] = 'No available kudos left.'
      redirect_to kudos_path
      return
    end
    if @kudo.save
      current_employee.decrement(:number_of_available_kudos).save
      redirect_to kudos_path, notice: 'Kudo was successfully created.'
    else
      render :new
    end
  end

  def update
    @kudo = find_kudo
    authorize!
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @kudo = find_kudo
    authorize!
    @kudo.destroy
    flash[:notice] = 'Kudo was successfully destroyed.'
    redirect_back fallback_location: kudos_path
  end

  private

  def find_kudo
    Kudo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :reciever_id, :company_value_id)
  end

  def authorize!
    raise AuthorizationError unless @kudo.giver == current_employee
  end
end
