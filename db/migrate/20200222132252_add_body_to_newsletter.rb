class AddBodyToNewsletter < ActiveRecord::Migration[5.2]
  def change
    add_column :newsletters, :body, :text
  end
end
