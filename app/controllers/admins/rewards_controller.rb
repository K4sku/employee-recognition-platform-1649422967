module Admins
  class RewardsController < BaseController
    def index
      @rewards = Reward.all
    end

    def show
      @reward = find_reward
    end

    def new
      @reward = Reward.new
    end

    def edit
      @reward = find_reward
      @possible_categories = Category.all - @reward.categories
    end

    def create
      @reward = Reward.new(reward_params)
      if @reward.save
        redirect_to admins_rewards_path, notice: 'Reward was successfully created.'
      else
        render :new
      end
    end

    def update
      @reward = find_reward
      if @reward.update(reward_params)
        redirect_to admins_reward_path(@reward), notice: 'Reward was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @reward = find_reward
      @reward.destroy
      redirect_to admins_rewards_path, notice: 'Reward was successfully destroyed.'
    end

    private

    def find_reward
      Reward.includes(:categories).find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :description, :price, category_ids: [])
    end
  end
end
