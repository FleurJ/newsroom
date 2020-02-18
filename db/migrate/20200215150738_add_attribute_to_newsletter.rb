class AddAttributeToNewsletter < ActiveRecord::Migration[5.2]
  def change
    add_column :newsletters, :press_review_date, :date
  end
end
