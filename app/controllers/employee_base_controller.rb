class EmployeeBaseController < ApplicationController
  before_action :authenticate_employee!
end
