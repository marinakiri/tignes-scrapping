class AddResortToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_reference :subscriptions, :resort, foreign_key: true
  end
end
