class LineItemsController < InheritedResources::Base
  before_action :set_categories_filters

  def create
    if current_user &.access
      product = Product.find(params[:product_id])
      @line_item = @cart.add_product(product)
      if @line_item.save
        redirect_to @line_item.cart, notice: 'Product was successfully add to the cart.'
      else
        redirect_to root_path, notice: 'Product not added to the cart.'
      end
    else
      redirect_to root_path, alert: 'Log in'
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end

