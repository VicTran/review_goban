class GuestOrdersController < ApplicationController
  
  def new
    unless params[:product_id].nil?
      @order = current_order.orders.find_by product_id: params[:product_id]
      @current_order = current_order
      if @order.nil?
        @current_order.save
        @current_order.orders.create(product_id: params[:product_id], number: 1)
        session[:gust_order_id] = @current_order.id
      else
        @order.update_attributes number: (@order.number + 1)
        session[:gust_order_id] = @current_order.id
      end
    else
      @current_order = current_order
    end
  end
  
  def create
    @guest_order = GuestOrder.find_by id: params[:guest_order_id]
    if @guest_order.update_attributes guest_order_params
      flash[:success] = t "guest_order.new_guest_order_successful"
      redirect_to edit_guest_order_path(@guest_order)
    else
      flash[:success] = t "guest_order.new_guest_order_unsuccessful"
      redirect_to edit_guest_order_path(@guest_order)
    end
  end

  def edit
    @current_order = GuestOrder.find_by id: params[:id]
  end

  def update
    @current_order = GuestOrder.find_by id: params[:id]
    if @current_order.update_attributes guest_order_params_update
      flash[:success] = t "guest_order.edit_guest_order_successful"
      redirect_to edit_guest_order_path(@current_order)
    else
      render :edit
    end
  end
  
  private
  def guest_order_params
    params.require(:guest_order).permit orders_attributes: [:id, :product_id, :number, :_destroy]
  end
  def guest_order_params_update
    params.require(:guest_order).permit :name_from, :email_from, :phone_from,
      :address_from, :name_to, :email_to, :address_to, :phone_to,
      orders_attributes: [:id, :product_id, :number, :_destroy]
  end
end
