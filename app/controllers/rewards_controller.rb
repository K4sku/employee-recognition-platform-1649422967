class RewardsController < EmployeeBaseController
  def index
    @rewards = if reward_params.key?('category')
                 Reward.includes(:categories)
                       .where("categories.title = '#{reward_params[:category]}'")
                       .references(:categories)
               else
                 Reward.all.includes(:categories)
               end
    @rewards = @rewards.page(params[:page])
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
