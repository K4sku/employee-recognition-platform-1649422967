class CreateCompanyValues < ActiveRecord::Migration[6.1]
  def change
    create_table :company_values do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_index :company_values, :title, unique: true
  end
end
