module CurrentCart

  private

  def set_cart
    if current_user
      session[:cart_id] = current_user.carts.last.id if current_user.carts.present?
    end
    @cart = Cart.find(session[:cart_id])
    @count = 0
    @cart.line_items.each { |p| @count += p.quantity }
  rescue ActiveRecord::RecordNotFound
    if current_user
      @cart = current_user.carts.create
    else
      @cart = Cart.create
    end
    session[:cart_id] = @cart.id
    @count = 0
  end
end