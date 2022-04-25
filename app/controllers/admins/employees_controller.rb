module Admins
  class EmployeesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_employee, only: %i[edit update destroy]

    # GET admins/pages/employees
    def index
      @employees = Employee.all.order('id ASC')
    end

    # GET admins/pages/employees/(:id)/edit
    def edit; end

    # PATCH/PUT admins/pages/employees/(:id)
    def update
      remove_password_from_hash_if_empty
      if @employee.update(employee_params)
        redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE admins/pages/employees/(:id)
    def destroy
      @employee.destroy
      flash[:notice] = 'Employee was successfully destroyed.'
      redirect_back fallback_location: kudos_path
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :number_of_available_kudos)
    end

    def remove_password_from_hash_if_empty
      return unless params[:employee][:password].strip.empty?

      params[:employee] = params[:employee].except(:password, :password_confirmation)
    end
  end
end
