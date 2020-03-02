module ApplicationHelper
  def full_title(title)
    "E-Commerce | #{title}"
  end

  def set_seller(seller)
    # if current_user.is_seller
      session[:seller_id] = seller.id
      @current_seller = current_user.seller
    # end
  end

  def current_seller
    if current_user && session[:seller_id]
      @current_seller ||= current_user.seller
    end
    @current_seller
  end

  def remove_seller_object
    puts "calling destroy"
    current_user.seller && current_user.seller.destroy
    @current_seller = nil
    current_user.save
    destroy_seller
    # TODO refactor above method
    #if destroy_seller
    #else
    end
  end

  def destroy_seller
    @current_seller = nil
    params.delete(:seller_id)
  end
end
