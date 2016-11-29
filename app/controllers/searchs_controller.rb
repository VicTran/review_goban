class SearchsController < ApplicationController
  def index
    @products = Product.all
    params[:q][:name_cont] = params[:q][:name_cont].strip.mb_chars.upcase.to_s
    @search = @products.ransack params[:q]
    @products = @search.result.page(params[:page]).per 8
  end
end
