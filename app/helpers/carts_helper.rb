module CartsHelper
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
end
