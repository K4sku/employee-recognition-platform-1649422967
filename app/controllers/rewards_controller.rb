class RewardsController < EmployeeBaseController
  def index
    @rewards = Reward.page(params[:page])
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
