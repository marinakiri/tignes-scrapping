class CreateAverages < ActiveRecord::Migration[5.1]
  def change
    create_table :averages do |t|
      t.date :start_date, index:true
      t.float :average_value
      t.integer :average_count
      t.integer :number_of_guests
      t.belongs_to :resort, index:true

      t.timestamps
    end
  end
end
