class StaticPagesController < ApplicationController
  def home
    @products = Product.display.sorted_by_price_rating.take 12
    @products_new = Product.display.order(created_at: :DESC).take 8
  end
end
