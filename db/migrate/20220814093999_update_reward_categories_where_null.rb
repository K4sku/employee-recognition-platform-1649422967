class UpdateRewardCategoriesWhereNull < ActiveRecord::Migration[6.1]
  def change
    @placeholder_category = Category.find_or_create_by(title: 'Placeholder')
    set_rewards_category_to_placeholder_where_not_set
  end

  def set_rewards_category_to_placeholder_where_not_set
    Reward.where.missing(:categories).each do |reward|
      reward.categories << @placeholder_category
    end
  end
end
