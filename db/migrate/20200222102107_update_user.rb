class UpdateUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :subscribed
    add_column :users, :subscribed, :boolean
  end
end
