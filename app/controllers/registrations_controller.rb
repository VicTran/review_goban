class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    if !params[:password].empty? || !params[:password_confirmation].empty?
      super
    else
      params.delete "current_password"
      resource.update_without_password(params)
    end
  end
  def after_update_path_for(resource)
    user_path(resource)
  end
end
