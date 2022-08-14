class AddUniqueIndexToCategoryRewardsTable < ActiveRecord::Migration[6.1]
  def change
    add_index :category_rewards, [:category_id, :reward_id], unique: true
  end
end
