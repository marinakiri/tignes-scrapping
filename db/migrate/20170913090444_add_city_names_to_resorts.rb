class AddCityNamesToResorts < ActiveRecord::Migration[5.1]
  def change
    add_column :resorts, :ville, :string
    add_index :resorts, :ville
    add_column :resorts, :ville_url, :string
    add_index :resorts, :ville_url
  end
end
