class AddAbritelClassifiedIdToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_column :classifieds, :abritel_classified_id, :string
    add_index :classifieds, :abritel_classified_id
  end
end
