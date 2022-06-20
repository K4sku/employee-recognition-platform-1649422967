class AddPurchasePriceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :purchase_price, :integer, null: false
  end
end
