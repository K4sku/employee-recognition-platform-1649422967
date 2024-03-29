class CreateCategoryRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :category_rewards do |t|
      t.references :category, index: true
      t.references :reward, index: true

      t.timestamps
    end
    add_index :category_rewards, [:category_id, :reward_id], unique: true
  end
end
