class AddResortToClassifieds < ActiveRecord::Migration[5.1]
  def change
    add_reference :classifieds, :resort, foreign_key: true
  end
end
