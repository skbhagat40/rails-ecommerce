class OrdersController < ApplicationController
  include CartsHelper

  #GET /order-summary
  def order_summary
    @total_price = 0
    session[:products].each do |pid, qty|
      @total_price += get_product_price(pid, qty)
      session[:total_amount] = @total_price
    end
    @current_address = current_user.address.find(session[:current_address])
  end

  #POST /create-order
  def create_order
    #clear the session (i.e) cart
    @order = current_user.orders.new
    @order.price = session[:total_amount]
    @order.address = Address.find(session[:current_address].to_i)
    if @order.save
      session[:products].each do |pid, qty|
        product = get_product(pid)
        if product
          OrderLineItem.create(order_id: @order.id, product_id: product.id, quantity: qty)
          product.stock = product.stock - qty || 0
          product.save
        end
      end
      remove_current_user_session_params
      flash[:alert] = "Your Order Has Been Placed Successfully"
    else
      flash[:alert] = "Something went wrong. please try again."
    end
    redirect_to root_path
  end

  # GET /my-orders
  def my_orders
    @user_order_history = current_user.orders
  end

  private

  def remove_current_user_session_params
    session[:products] = Hash.new
    session.delete(:total_amount)
    session.delete(:current_address)
  end
end
