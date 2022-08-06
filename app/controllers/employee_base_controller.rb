class EmployeeBaseController < ApplicationController
  before_action :authenticate_employee!
  def pundit_user
    current_employee
  end
end
