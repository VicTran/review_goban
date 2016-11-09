class CreateGuestOrders < ActiveRecord::Migration
  def change
    create_table :guest_orders do |t|
      t.string :name_from
      t.string :email_from
      t.string :phone_from
      t.string :address_from
      t.string :name_to
      t.string :email_to
      t.string :phone_to
      t.string :address_to
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
