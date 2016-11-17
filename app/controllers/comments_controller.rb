class CommentsController < ApplicationController
#   load_and_authorize_resource
  def create
    @product = Product.find_by id: params[:product_id]
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to product_path(@product)
    else
      flash[:warning]= t "can_not_comment"
      redirect_to product_path(@product)
    end
  end

  def update
    @comment = Comment.find_by id: params[:id]
    if @comment.update_attributes comment_params
      flash[:success] = ""
    else
      flash[:danger] = ""
    end
    redirect_to product_path(@comment.product)
  end

  def destroy
    @product = Product.find_by id: params[:product_id]
  	@comment = @product.comments.find_by id: params[:id]
  	@comment.destroy
  	respond_to do |format|
      format.html do
        flash[:success] = t "comment_delete"
        redirect_to product_path(@product)
      end
      format.js # JavaScript response
    end
  end
  private
  def comment_params
    params.require(:comment).permit( :content)
  end
end
