class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :bookmarks, [:user_id, :product_id], unique: true
  end
end
