class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    resource.soft_destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource) do
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  private

  def resource_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :country_id, :terms_of_service,
      :password, :password_confirmation, :current_password)
  end
end
