class GuestOrder < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :orders, allow_destroy: true

  def sum_price
    sum = 0
    self.orders.each do |order|
      sum += order.product.price * order.number *
        (1 - order.product.promotion.to_f/100)
    end
    return sum.to_i
  end
end
