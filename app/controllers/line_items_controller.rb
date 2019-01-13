class LineItemsController < InheritedResources::Base
  before_action :set_categories_filters
  before_action :set_line_item, only: [:minus_quantity, :destroy]

  def create
    if current_user &.access
      product = Product.find(params[:product_id])
      @line_item = @cart.add_product(product)
      if @line_item.save
        respond_to do |format|
          format.html { redirect_to @line_item.cart }
          format.js { @current_item = @line_item }
          format.json { render :show, status: :created, location: @line_item }
        end
      else
        redirect_to root_path, notice: 'Product not added to the cart.'
      end
    else
      redirect_to root_path, alert: 'Log in'
    end
  end

  def minus_quantity
    @line_item.quantity > 1 ? @line_item.quantity -= 1 : destroy
    if @line_item.save
      respond_to do |format|
        format.html { redirect_to @line_item.cart }
        format.js { @current_item = @line_item }
      end
    end
  end


  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart) }
      format.js
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end

