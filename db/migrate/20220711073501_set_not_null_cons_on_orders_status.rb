class SetNotNullConsOnOrdersStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_null :orders, :status, false
  end
end
