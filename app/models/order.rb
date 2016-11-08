class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :guest_order
end
