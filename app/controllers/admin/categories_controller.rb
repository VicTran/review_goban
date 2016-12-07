class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  def index
    @categories = Category.all.page(params[:page]).
      per 10
  end

  def show
  end

  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "message.new_category_successful"
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "message.edit_category_successful"
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "message.delete_category_successful"
      redirect_to admin_categories_path
    else
      flash[:success] = t "message.delete_category_unsuccessful"
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :content, :image
  end
end
