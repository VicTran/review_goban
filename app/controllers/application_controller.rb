class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :build_temporary_cart

  def build_temporary_cart
    session[:order_products] = [] if session[:order_products].nil?
  end

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
      else
        GuestOrder.find(session[:gust_order_id])
      end
    else
      GuestOrder.new
    end
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
end
