class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :guest_order, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :number

      t.timestamps null: false
    end
  end
end
