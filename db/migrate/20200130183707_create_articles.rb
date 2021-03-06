class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.date :publication_date
      t.string :source_name
      t.string :source_url
      t.text :body
      t.references :user, foreign_key: true
      t.string :status
      t.text :teaser

      t.timestamps
    end
  end
end
