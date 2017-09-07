class CreateClassifieds < ActiveRecord::Migration[5.1]
  def change
    create_table :classifieds do |t|
      t.date :start_date
      t.date :end_date
      t.string :title
      t.float :price
      t.integer :number_of_guests
      t.string :link
      
      t.timestamps
    end
  end
end
