module CurrentCart

  private

  def set_cart
    if current_user
      session[:cart_id] = current_user.carts.last.id if current_user.carts.last.present?
    end
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    if current_user
      @cart = current_user.carts.create
      session[:cart_id] = @cart.id
    else
      @cart = Cart.new
    end
  end
end