# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # TODO move this to a private method
  def add_seller
    if current_user.try(:is_seller)
      # puts (current_user.methods)
      # puts "user"
      # puts User.find(current_user.id).name
      if current_user.seller.nil?
      @seller = Seller.new
      @seller.user_id = current_user.id
      @seller.save
      else
        @seller = current_user.seller
      end
      set_seller(@seller)
    end
  end
  def create
    super
    add_seller
  end

  # GET /resource/edit
  def edit
    super
    add_seller
  end

  # PUT /resource
  def update
    super
    puts "params are #{params}"
    if params[:is_seller]
      if current_user.seller.nil?
        current_user.seller = Seller.create(user_id: current_user.id)
        current_user.save
      end
      set_seller(current_user.seller)
    else
      remove_seller_object
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
