class AddStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :integer
    add_index :orders, :status
  end
end
