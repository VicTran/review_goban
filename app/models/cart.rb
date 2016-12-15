class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  def sum_price
    sum = 0
    self.order_items.each do |order_item|
      sum += order_item.product.price * order_item.number *
        (1 - order_item.product.promotion.to_f/100)
        # byebug
    end
    return sum.to_i
  end
end
