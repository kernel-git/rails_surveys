# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LoggerExtension

  # before_action :configure_permitted_parameters, if: :devise_controller?, only:

  # def configure_permitted_parameters
  #   case params[:account][:account_type]
  #   when 'admin'
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  #   when 'employer'
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  #   when 'employee'
  #     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :account_type,
  #         :age, :position_age, :employer_id])
  #   end
  # end

  # def after_sign_in_path_for(resource)
  #   Rails.logger.debug resource_name
  #   case resource_name
  #   when :administrator
  #     admin_root_url
  #   when :employee
  #     employee_root_url
  #   when :employer
  #     employer_root_url
  #   end
  # end
end
