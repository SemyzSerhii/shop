class LineItemsController < InheritedResources::Base
  before_action :set_categories_filters
  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    if current_user &.access
      product = Product.find(params[:product_id])
      @line_item = @cart.line_items.build(product: product)
      respond_to do |format|
        if @line_item.save
          format.html { redirect_to @line_item.cart,
                                    notice: 'Line item was successfully created.' }
          format.json { render :show,
                               status: :created, location: @line_item }
        else
          format.html { render :new }
          format.json { render json: @line_item.errors,
                               status: :unprocessable_entity }
        end
      end
    else
      redirect_access(@product)
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end

