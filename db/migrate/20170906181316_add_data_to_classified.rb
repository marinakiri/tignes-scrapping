class AddDataToClassified < ActiveRecord::Migration[5.1]
  def change
    add_column :classifieds, :json_data, :jsonb
  end
end
