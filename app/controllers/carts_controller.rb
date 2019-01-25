class CartsController < InheritedResources::Base
  before_action :set_categories_filters
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path, notice: 'Your cart is currently empty'
  end

  private

  def cart_params
    params.require(:cart).permit(:user_id)
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, alert: 'Invalid cart'
  end
end

