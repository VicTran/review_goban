class SearchsController < ApplicationController
  def index
    @products = Product.all
    @search = @products.ransack params[:q]
    if params[:q].nil?
      @products = @products.page(params[:page]).per 8
    else
      @products = @search.result.page(params[:page]).per 8
    end
  end
end
