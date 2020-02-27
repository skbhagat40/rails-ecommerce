class HomePagesController < ApplicationController
  include CartsHelper

  def index
    @categories = Product.categories
    @verticals = Product.verticals
  end

  # GET /products/category/:category_id
  def products_by_category
    @products = Product.where(category: params[:category_id])
  end

  #GET /checkout
  def checkout
    @addresses = current_user.address
  end

  # GET /search
  # params - title
  def search
    @search_results = Product.where(title: params[:title])
  end

  #GET /seller-history
  def seller_history
    @sold_products = current_user.seller.order_line_items.group(:product_id).sum(:quantity)
    @total_revenue = 0
    @sold_products.each do |pid, qty|
      @total_revenue += get_product_price(pid, qty)
    end
  end
end
