class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :ville
      t.integer :number_of_guests

      t.timestamps
    end
  end
end
