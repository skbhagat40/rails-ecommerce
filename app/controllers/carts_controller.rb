class CartsController < ApplicationController
  include CartsHelper

  #GET /cart
  def my_cart
    @cart_items = session[:products]
  end

  #POST products/add/
  # params - product_id, quantity
  def add_product_to_cart
    request_params = eval(request.body.read)
    session[:products][request_params[:product_id]] = request_params[:quantity]
    if request_params[:wishlist]
      wishlist_item = current_user.wishlist.find_by(product_id: request_params[:product_id].to_i)
      wishlist_item&.destroy
    end
    render json: {status: 200, message: "Product Added To Cart Successfully!"}
  end

  #PUT products/update/
  def update_cart_item
    if params.key?(:product_id)
      session[:products][params[:product_id]] = params[:quantity]
    end
    if params.key?(:current_address)
      session[:current_address] = params[:current_address]
    end
    redirect_to params[:redirect] || my_cart_path
  end

  #DELETE products/:product_id
  def delete_cart_item
    session[:products].delete(params[:product_id])
    redirect_to my_cart_path
  end

end
