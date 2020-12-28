class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    case resource_name
    when :administrator
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    when :user
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :account_type, 
          :age, :position_age, :client_id])
    end
  end

  def after_sign_in_path_for(resource)
    puts resource_name
    case resource_name
    when :administrator
      admin_root_url
    when :user
      user_root_url
    when :client
      company_root_url
    end
  end

end
