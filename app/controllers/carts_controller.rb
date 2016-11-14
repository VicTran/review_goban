class CartsController < ApplicationController
  before_action :check_current_order, only: [:edit, :update]
  before_action :check_params, only: [:create, :update]

  def index
    @carts = current_user.carts
  end

  def new
    unless params[:product_id].nil?
      @order_item = current_cart.order_items.find_by product_id: params[:product_id]
      if @order_item.nil?
        current_cart.order_items.create(product_id: params[:product_id], number: 1)
      else
        @order_item.update_attributes number: (@order_item.number + 1)
      end
    end
    @current_cart = current_cart
  end

  def create
    @cart = Cart.find_by id: params[:cart_id]
    if @cart.update_attributes cart_params
      @cart.order_items.each do |order_item|
        order_item.destroy if order_item.number == 0
      end
      flash[:success] = t "cart.new_cart_successful"
      redirect_to edit_cart_path(@cart)
    else
      flash[:success] = t "cart.new_cart_unsuccessful"
      redirect_to edit_cart_path(@cart)
    end
  end

  def edit
    @cart = Cart.find_by id: params[:id]
  end

  def update
    @cart = Cart.find_by id: params[:id]
    if @cart.update_attributes cart_params
      @cart.update_attributes status: 1
      flash[:success] = t "cart.edit_cart_successful"
      redirect_to cart_path(@cart)
    else
      render :edit
    end
  end

  def show
    @cart = Cart.find_by id: params[:id]
  end

  private
  def cart_params
    params.require(:cart).permit order_items_attributes: [:id,
      :product_id, :number, :_destroy]
  end
  def check_current_order
    @cart = Cart.find_by id: params[:id]
    if @cart.status == 1
      flash[:danger] = "You can not do it"
      redirect_to root_path
    end
  end

  def check_params
    @cart = Cart.find_by id: params[:id]
    @cart ||= Cart.find_by id: params[:cart_id]
    if params[:cart].nil?
      a = {}
    else
      a = params[:cart][:order_items_attributes].select{|a,b| b[:_destroy] == "false"}
      @cart.update_attributes cart_params
    end
    if a.empty?
      flash[:danger] = "Chua co sp nao"
      redirect_to new_cart_path(@cart)
    end
  end
end
