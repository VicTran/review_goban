class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "not_authorized"
    redirect_to root_url
  end

  def current_order
    unless session[:gust_order_id].nil?
      @a = GuestOrder.find_by id: session[:gust_order_id]
      if @a.nil?
        session.delete :gust_order_id
        GuestOrder.new
      elsif @a.status == 1
        GuestOrder.new
      else
        GuestOrder.find(session[:gust_order_id])
      end
    else
      GuestOrder.new
    end
  end

  def current_cart
    # if user_signed_in?
      @cart = current_user.carts.where(status: 0).first
      if @cart.nil?
        current_user.carts.create
        @cart = current_user.carts.where(status: 0).first
      end
      @cart
    # end
  end
  private
  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:name,
      :email, :password, :password_confirmation, :picture, :gender,
      :country, :state, :phone, :birthday)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:name,
      :email, :password, :password_confirmation, :picture, :gender,
      :country, :state, :phone, :current_password, :birthday)}
  end

  def layout_by_resource
    if  user_signed_in? && current_user.admin?
      "admin_application"
    elsif user_signed_in? && !current_user.admin?
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_root_path
    else
      super
    end
  end
end
