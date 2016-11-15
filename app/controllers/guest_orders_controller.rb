class GuestOrdersController < ApplicationController
  before_action :check_current_order, only: [:edit, :update]
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
      @guest_order.orders.each do |order_item|
        order_item.destroy if order_item.number == 0
      end
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
    if !validate_edit_form params
      render :edit
    elsif @current_order.update_attributes guest_order_params_update
      @current_order.update_attributes status: 1
      flash[:success] = t "guest_order.edit_guest_order_successful"
      redirect_to guest_order_path(@current_order)
    else
      render :edit
    end
  end

  def show
    @current_order = GuestOrder.find_by id: params[:id]
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

  def validate_edit_form params
    name_from = params[:guest_order][:name_from]
    email_from = params[:guest_order][:email_from]
    phone_from = params[:guest_order][:phone_from]
    address_from = params[:guest_order][:address_from]
    name_to = params[:guest_order][:name_to]
    email_to = params[:guest_order][:email_to]
    address_to = params[:guest_order][:address_to]
    phone_to = params[:guest_order][:phone_to]
    @current_order.errors.add :name_from, "Name of buyer not empty" unless name_from.present?
    @current_order.errors.add :email_from, "Email of buyer not empty" unless email_from.present?
    @current_order.errors.add :phone_from, "Phone of buyer not empty" unless phone_from.present?
    @current_order.errors.add :address_from, "Address of buyer not empty" unless address_from.present?
    @current_order.errors.add :name_to, "Name of receiver not empty" unless name_to.present?
    @current_order.errors.add :email_to, "Email of receiver not empty" unless email_to.present?
    @current_order.errors.add :address_to, "Phone of receiver not empty" unless address_to.present?
    @current_order.errors.add :phone_to, "Address of receiver not empty" unless phone_to.present?
    name_from.present? && email_from.present? && phone_from.present? &&
      address_from.present? && name_to.present? && email_to.present? &&
      address_to.present? && phone_to.present?
  end

  def check_current_order
    @current_order = GuestOrder.find_by id: params[:id]
    if @current_order.status == 1
      flash[:danger] = "You can not do it"
      redirect_to root_path
    end
  end
end
