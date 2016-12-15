class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
<<<<<<< HEAD
    resource.update_without_password(params)
=======
    if !params[:password].empty? || !params[:password_confirmation].empty?
      super
    else
      params.delete "current_password"
      resource.update_without_password(params)
    end
>>>>>>> c45300588f3ac4fd5dac8a6039d3736ba68d88ba
  end
  def after_update_path_for(resource)
    user_path(resource)
  end
end
