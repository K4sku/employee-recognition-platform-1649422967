class AddStatusToOrders < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE order_status AS ENUM ('placed', 'delivered', 'not_set');
    SQL
    add_column :orders, :status, :order_status
    add_index :orders, :status
  end

  def down
    remove_column :orders, :status
    remove_index :orders, :status
    execute <<-SQL
      DROP TYPE order_status
    SQL
  end
end
