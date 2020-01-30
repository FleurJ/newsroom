class CreateNewsletters < ActiveRecord::Migration[5.2]
  def change
    create_table :newsletters do |t|
      t.string :title
      t.string :type
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
