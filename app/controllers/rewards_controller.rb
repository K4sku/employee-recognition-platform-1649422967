class RewardsController < EmployeeBaseController
  def index
    @rewards = FilterPaginatedRewards.call(category: reward_params[:category],
                                           page: reward_params[:page])
    @category_titles = Category.pluck(:title)
  end

  def show
    @reward = Reward.find(params[:id])
  end

  private

  def reward_params
    params.permit(:category, :page)
  end
end
