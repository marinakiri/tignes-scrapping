class AddAbritelIdsToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_column :classifieds, :abritel_id, :integer
    add_index :classifieds, :abritel_id
  end
end
