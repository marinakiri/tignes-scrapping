class CreateClassifieds < ActiveRecord::Migration[5.1]
  def change
    create_table :classifieds do |t|
      t.date :startDate
      t.date :endDate
      t.string :title
      t.float :price
      t.integer :numberOfGuests
      t.string :link
      
      t.timestamps
    end
  end
end
