class AddColumnsToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_column :classifieds, :country, :string
    add_index :classifieds, :country
    add_column :classifieds, :region, :string
    add_index :classifieds, :region
    add_column :classifieds, :departement, :string
    add_index :classifieds, :departement
    add_column :classifieds, :ville, :string
    add_index :classifieds, :ville
    add_column :classifieds, :quartier, :string
    add_index :classifieds, :quartier
  end
end
