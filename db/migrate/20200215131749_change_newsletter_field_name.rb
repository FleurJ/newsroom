class ChangeNewsletterFieldName < ActiveRecord::Migration[5.2]
  def change
    rename_column :newsletters, :type, :newsletter_type
  end
end
