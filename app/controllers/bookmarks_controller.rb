class BookmarksController < ApplicationController
#   load_and_authorize_resource
  def create
    @product = Product.find_by id: params[:product_id]
    @bookmark = current_user.bookmarks.new
    @bookmark.product_id = @product.id
    if @bookmark.save
      redirect_to product_path(@product)
    else
      flash[:warning]= t "can_not_bookmark"
      redirect_to product_path(@product)
    end
  end
  def destroy
    @product = Product.find_by id: params[:id]
    @bookmark = current_user.bookmarks.find_by product_id: @product.id
    if @bookmark.destroy
      redirect_to product_path(@product)
    else
      flash[:warning]= t "can_not_unbookmark"
      redirect_to product_path(@product)
    end
  end
end
