class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @users.all.ransack params[:q]
    if params[:q].nil?
      @users = @users.page(params[:page]).per 10
    else
      @users = @search.result.page(params[:page]).per 10
    end
  end

  def create
    if @user.save
      flash[:success] = t "message.new_user_successful"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  # def update
  #   if @user.update_attributes user_params
  #     flash[:success] = t "message.edit_user_successful"
  #     redirect_to admin_users_path
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    if @user.destroy
      flash[:success] = t "message.delete_user_successful"
    else
      flash[:danger] = t "message.delete_user_unsuccessful"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :picture, :gender, :country, :state,
      :phone, :birthday
  end
end
