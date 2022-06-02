class RewardsController < EmployeeBaseController
  def index
    @rewards = Reward.all
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
