class AddPurchasePriceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :purchase_price, :integer
    update_orders_current_price_where_not_set
    change_column_null :orders, :purchase_price, false
  end

  def update_orders_current_price_where_not_set
    Order.all.each do |order|
      if order.purchase_price.nil? 
        order.purchase_price = order.reward.price
        order.save
      end
    end
  end
end
