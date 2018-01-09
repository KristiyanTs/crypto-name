class Users::SessionsController < Devise::SessionsController

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      set_flash_message(:alert, :signed_in)
      sign_in :user, resource
      return render nothing: true
    end

    invalid_login_attempt
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message(:alert, :signed_out) if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
  
  private 

  def after_sign_in_path_for(resource)
    search_index_path
  end

  def after_sign_out_path_for(resource_or_scope)
    search_index_path
  end

  def respond_to_on_destroy
    respond_to do |format|
      format.js
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: flash[:alert], status: 401
  end
end
