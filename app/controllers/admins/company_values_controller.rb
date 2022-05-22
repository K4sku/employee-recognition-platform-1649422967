module Admins
  class CompanyValuesController < BaseController
    def index
      @company_values = CompanyValue.all.order('title')
    end

    def show
      @company_value = find_company_value
    end

    def new
      @company_value = CompanyValue.new
    end

    def edit
      @company_value = find_company_value
    end

    def create
      @company_value = CompanyValue.new(company_value_params)
      if @company_value.save
        redirect_to admins_company_values_path, notice: 'Company Value was successfully created.'
      else
        render :new
      end
    end

    def update
      @company_value = find_company_value
      if @company_value.update(company_value_params)
        redirect_to admins_company_value_path(@company_value), notice: 'Company Value was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @company_value = find_company_value
      @company_value.destroy
      flash[:notice] = 'Company Value was successfully destroyed.'
      redirect_back fallback_location: admins_company_values_path
    end

    private

    def find_company_value
      CompanyValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
