class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :articles, :type, :article_type.
  end
end
