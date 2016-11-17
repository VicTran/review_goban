class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :guest_order
  def sum_price
    self.product.price * self.number * (1 - self.product.promotion.to_f/100)
  end
end
