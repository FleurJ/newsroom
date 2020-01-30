class CreateNewsletterArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletter_articles do |t|
      t.references :newsletter, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
