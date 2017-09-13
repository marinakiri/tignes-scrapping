class AddRegionNumberToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_column :classifieds, :region_number, :string
    add_index :classifieds, :region_number
  end
end
