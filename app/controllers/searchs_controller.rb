class SearchsController < ApplicationController
  def index
    @products = Product.all
    @search = @products.ransack params[:q]
    if params[:q].nil?
      @products = @products.page(params[:page]).per 9
    else
      @products = @search.result.page(params[:page]).per 9
    end
  end
end
