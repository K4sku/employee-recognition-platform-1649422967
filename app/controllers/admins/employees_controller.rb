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

    def add_kudos_form
      render 'add_kudos_form'
    end

    def add_kudos
      kudos_number = add_kudos_params[:number_of_available_kudos_to_add].to_i
      unless kudos_number.between?(1, 20)
        flash[:alert] = 'Number of additional kudos must be in range 1 to 20.'
        render 'add_kudos_form'
        return
      end
      Employee.add_kudos_to_all(kudos_number)
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e
      render 'add_kudos_form'
    else
      redirect_to admins_employees_path,
                  notice: "All employees recieved #{kudos_number} available kudos."
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :password, :password_confirmation, :number_of_available_kudos)
    end

    def add_kudos_params
      params.permit(:authenticity_token, :number_of_available_kudos_to_add, :commit)
    end

    def remove_password_from_hash_if_empty
      return unless params[:employee][:password].strip.empty?

      # remove password and password_confirmation from params if password filed was left empty or has only whitespace
      params[:employee] = params[:employee].except(:password, :password_confirmation)
    end
  end
end
