module Admins
  class EmployeesController < BaseController
    def index
      @employees = Employee.all.order('id ASC')
    end

    def show
      employee
    end

    def edit
      employee
    end

    def update
      remove_password_from_hash_if_empty
      if employee.update(employee_params)
        redirect_to admins_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      employee.destroy
      flash[:notice] = 'Employee was successfully destroyed.'
      redirect_back fallback_location: kudos_path
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :number_of_available_kudos)
    end

    def remove_password_from_hash_if_empty
      return unless params[:employee][:password].strip.empty?

      # remove password and password_confirmation from params if password filed was left empty or has only whitespace
      params[:employee] = params[:employee].except(:password, :password_confirmation)
    end
  end
end
