class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :first_name, :string
    add_column :users, :agora_profil, :string
    add_column :users, :status, :string
    add_column :users, :role, :string
  end
end
