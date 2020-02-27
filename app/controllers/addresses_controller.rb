class AddressesController < ApplicationController
  # before_action {@@redirect_path = nil}
  before_action :set_address, only: [:edit, :update, :destroy]
  after_action :remove_redirect, only: [:update, :destroy]
  def index
    @addresses = current_user.addresses
  end

  def edit
    # puts "params, #{params[:redirect]}"
    @@redirect_path = params[:redirect]
  end

  def update
    # @address = current_user.address.new(address_params)
    if @address.update(address_params)
      puts "redirect path #{@redirect_path}"
      puts "params #{params}"
      redirect_to @@redirect_path || users_addresses_path(@address, notice: "Address was created successfully")
    else
      render 'new'
    end
  end

  def new
    @@redirect_path = params[:redirect]
    @address = current_user.address.new
  end

  def create
    @address = current_user.address.new(address_params)
    if @address.save
      redirect_to @@redirect_path || users_address_path(@address, notice: "Address was created successfully")
    else
      render 'new'
    end
  end

  def destroy
    puts "called"
    session.delete(:current_address)
    @address.destroy
    current_user.save
    redirect_to params[:redirect]
  end

  private
  def set_address
    # puts "params #{params}"
    # @@redirect_path = nil
    @address = current_user.address.find(params[:id])
  end
  def address_params
    params.require(:address).permit([:locality, :state, :country, :pin_code, :address_type])
  end
  def remove_redirect
    @@redirect_path = nil
  end
end
