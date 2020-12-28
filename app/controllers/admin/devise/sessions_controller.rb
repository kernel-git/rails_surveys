# frozen_string_literal: true

class Admin::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    print("Ping from admin/devise/session#new")
    super
  end

  # POST /resource/sign_in
  def create
    print("Ping from admin/devise/session#create")
    super
  end

  #DELETE /admin/sign_out
  def destroy
    print("Ping from admin/devise/session#destroy")
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
