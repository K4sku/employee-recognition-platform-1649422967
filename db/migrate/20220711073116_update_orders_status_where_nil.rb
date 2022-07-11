class UpdateOrdersStatusWhereNil < ActiveRecord::Migration[6.1]
  def change
    set_orders_status_to_placed_where_not_set
  end

  def set_orders_status_to_placed_where_not_set
    Order.where(status: nil).each do |order|
      order.placed_status!
    end
  end
end
