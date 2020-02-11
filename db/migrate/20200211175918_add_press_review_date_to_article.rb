class AddPressReviewDateToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :press_review_date, :date
  end
end
