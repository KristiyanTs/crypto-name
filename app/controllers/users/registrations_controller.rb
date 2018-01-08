class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message(:alert, :"signed_up_but_#{resource.inactive_message}")
        expire_data_after_sign_in!
        return render nothing: true
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: resource.errors }, status: 401
    end
  end

  protected

  def additional_paramteres
    [:first_name, :last_name, :email, :password, :password_confirmation, :terms_of_service]
  end

  def after_sign_up_path_for
    new_user_session_path
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_paramteres)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: additional_paramteres)
  end
end
