class WishlistsController < ApplicationController

  #POST products/wishlist/
  # params- product_id
  def add_product_to_wishlist
    request_params = eval(request.body.read)
    @wishlist = current_user.wishlist.where(product_id: request_params[:product_id]).first_or_initialize
    @wishlist.product = Product.find_by(id: request_params[:product_id])
    if @wishlist.save
      render json: {status: 200, message: "Product Added To Wishlist Successfully!"}
    else
      render json: {status: 400, message: "Something went wrong"}
    end
  end

  #GET /wishlist
  def my_wishlist
    @wishlists = current_user.wishlist
  end

  #DELETE /wishlist/:id
  def destroy
    current_user.wishlist.find(params[:id]).destroy
    redirect_to my_wishlist_path
  end

end
