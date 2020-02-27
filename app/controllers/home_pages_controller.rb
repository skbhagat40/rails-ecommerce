class HomePagesController < ApplicationController

  def index
    @categories = Product.categories
    @verticals = Product.verticals
  end

  # GET /products/category/:category_id
  def products_by_category
    @products = Product.where(category: params[:category_id])
  end

  #POST products/add/
  # params - product_id, quantity
  def add_product_to_cart
    request_params = eval(request.body.read)
    session[:products][request_params[:product_id]] = request_params[:quantity]
    render json: {status: 200, message: "Product Added To Cart Successfully!"}
  end

  #PUT products/update/
  def update_cart_item
    if params.key?(:product_id)
      session[:products][params[:product_id]] = params[:quantity]
    end
    if params.key?(:current_address)
      puts "update address params #{params}"
      session[:current_address] = params[:current_address]
    end
    redirect_to params[:redirect] || my_cart_path
  end

  #DELETE products/:product_id
  def delete_cart_item
    session[:products].delete(params[:product_id])
    redirect_to my_cart_path
  end

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
    @wishlists = Wishlist.all
  end

  #GET /cart
  def my_cart
    @cart_items = session[:products]
  end

  #GET /checkout
  def checkout
    @addresses = current_user.address
  end

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

  # GET /search
  # params - title
  def search
    puts "params #{params[:title]}"
    @search_results = Product.where(title: params[:title])
    puts "search results #{@search_results}"
    # render 'search'
    # redirect_to search_path
    # puts "products are #{@search_results.length}"
    # redirect_to root_path
  end

  def seller_history
    @sold_products = current_user.seller.order_line_items.group(:product_id).count
    puts "sold products **" * 20
    puts @sold_products
    @total_revenue = 0
    @sold_products.each do |pid, qty|
      @total_revenue += get_product_price(pid, qty)
      puts @total_revenue
    end
    puts "total revenue #{@total_revenue}"
  end

  private

  def get_product(pid)
    if pid.is_a? String
      pid.scan(/\D/).empty? ? Product.find_by(id: pid) : nil
    else
      Product.find(pid)
    end
  end

  def get_product_price(product_id, quantity)

    product_discounted_price = lambda { |product| (product.price.to_f - ((product.discount.to_f || 0) / 100) * product.price.to_f) * quantity.to_f }

    product = get_product(product_id)
    if product
      product_discounted_price.call(product)
    else
      0
    end
  end

  def remove_current_user_session_params
    session.delete(:products)
    session.delete(:total_amount)
    session.delete(:current_address)
  end
end
