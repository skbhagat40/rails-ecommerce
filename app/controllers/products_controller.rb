class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy, :remove_product_image]
  before_action :validate_seller, only: [:edit, :update, :destroy]
  include ApplicationHelper
  # POST /products/:product_id/image/:image_id
  # remove_product_image
  def remove_product_image
    # puts "params #{params}"
    # ActiveStorage::Blob.find_signed(params[:image_id]).purge
    @product.images.find(params[:image_id]).purge
    # byebug
    redirect_to seller_product_path(current_seller.id, @product.id)
    # @product.images[params[:image_id]].purge
  end
  # GET /products
  # GET /products.json
  def index
    @products = current_seller.product.all
  end
  #  POST /products/add/:product_id
  def update_quantity
    # session[:cart][params[:product_id]]
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product ||= Product.new
    @product.seller_id = current_seller.id
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create

    @product = Product.new(product_params)
    @product.images.attach(params[:product][:images]) if params[:product][:images]

    respond_to do |format|
      if @product.save
        format.html { redirect_to seller_product_path(current_seller.id, @product.id), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        puts "called #{params}"
        @product.images.attach(params[:product][:images]) if params[:product][:images]
        format.html { redirect_to seller_product_path(current_seller.id, @product.id), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to seller_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_seller.product.find(params[:id])
    end

  def validate_seller
    if current_user && current_user.seller.user_id == current_user.id
      true
    else
      redirect_to new_user_session
    end
  end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:seller_id, :name, :title, :description, :price, :stock, :vertical, :category, :discount, :images)
      # pramas['product']['vertical'].to_i!
    end
end
