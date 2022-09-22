module Admins
  class RewardsController < BaseController
    def index
      @rewards = Reward.with_attached_image.includes(:categories)
    end

    def show
      @reward = find_reward
    end

    def new
      @reward = Reward.new
      @possible_categories = Category.all
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
        @possible_categories = Category.all - @reward.categories
        render :new
      end
    end

    def update
      @reward = find_reward
      if @reward.update(reward_params)
        redirect_to admins_reward_path(@reward), notice: 'Reward was successfully updated.'
      else
        @possible_categories = Category.all - @reward.categories
        render :edit
      end
    end

    def destroy
      @reward = find_reward
      @reward.destroy
      redirect_to admins_rewards_path, notice: 'Reward was successfully destroyed.'
    end

    def upload_rewards; end

    def import_from_csv
      uploaded_file = params[:rewards_csv]
      uploaded_file_path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
      File.binwrite(uploaded_file_path, uploaded_file.read)

      service = ImportRewardsService.new(uploaded_file_path)
      if service.call
        redirect_to admins_rewards_path, notice: 'Rewards were successfully uploaded.'
      else
        render :upload_rewards, locals: { errors: service.errors }
      end
      redirect_to admins_rewards_path, alert: 'Something went wrong. Try again later.'
    end

    private

    def find_reward
      Reward.includes(:categories).find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:title, :description, :price, :image, category_ids: [])
    end
  end
end
