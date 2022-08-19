class AddNotNullContraintOnCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:category_rewards, :category_id, false)
    change_column_null(:category_rewards, :reward_id, false)
  end
end
