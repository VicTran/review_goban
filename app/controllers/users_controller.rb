class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    unless current_user == @user
      flash[:danger] = t "not_authorized"
      redirect_to root_url
    end
  end
end
