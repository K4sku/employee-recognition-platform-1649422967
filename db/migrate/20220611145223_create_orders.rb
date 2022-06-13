class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :employee, null: false
      t.references :reward, null: false

      t.timestamps
    end
  end
end
