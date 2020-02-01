class CreateStaticPages < ActiveRecord::Migration[5.2]
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
