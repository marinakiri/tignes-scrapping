class AddRegionNumberToResorts < ActiveRecord::Migration[5.1]
  def change
    add_column :resorts, :region_number, :string
    add_index :resorts, :region_number
  end
end
