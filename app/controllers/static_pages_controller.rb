class StaticPagesController < ApplicationController
  def home
    @products = Product.display.sorted_by_price_rating.take 9
  end
end
