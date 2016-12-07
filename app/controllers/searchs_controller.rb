class SearchsController < ApplicationController
  def index
    @products = Product.all
    params[:q][:name_cont] = params[:q][:name_cont].strip.mb_chars.upcase.to_s
    @search = @products.ransack params[:q]
    @products = @search.result.page(params[:page]).per 8
    unless params[:star_minimun].nil? || params[:star_minimun].empty?
      @star_minimun = params[:star_minimun]
      @products = @products.get_by_minimun_star params[:star_minimun]
    end
    unless params[:star_maximun].nil? || params[:star_maximun].empty?
      @star_maximun = params[:star_maximun]
      @products = @products.get_by_maximun_star params[:star_maximun]
    end
  end
end
