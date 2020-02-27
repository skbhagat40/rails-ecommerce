# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    session[:products] = Hash.new()
    if current_user.is_seller
      set_seller(current_user.seller)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
    session.delete(:products)
    destroy_seller
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_up).push(:name, :surname,:username, :email, :avatar)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
