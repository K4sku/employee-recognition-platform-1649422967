class AddCompanyValuesRefToKudos < ActiveRecord::Migration[6.1]
  def change
    add_reference :kudos, :company_value
    change_column_null :kudos, :company_value_id, false, 1
  end
end
