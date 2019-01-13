class OrdersController < InheritedResources::Base
  before_action :set_categories_filters
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.find_by_user_id(current_user.id)
  end

  def new
    @order = Order.new
  end

  def create
    params[:order][:user_id] = current_user.id
    @order = Order.new(order_params)
    @order.status = 'In processing'
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to @order, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    redirect_access(root_path) unless check_access(@order) && @order.status == 'In processing'
  end

  def update
    if check_access(@order) && @order.status == 'In processing'
      if @order.update(order_params)
        redirect_to @order, notice: 'Order updated.'
      else
        render 'edit'
      end
    else
      redirect_access(root_path)
    end
  end

  def destroy
    if @order.status == 'Canceled'
      redirect_access(root_path)
    else
      @order.update_columns(status: 'Canceled')
      redirect_to @order, notice: 'Order canceled.'
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])


  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit(:user_id, :address)
  end

  def ensure_cart_isnt_empty
    if @cart.line_items.empty?
      redirect_to root_path, notice: 'Your cart is empty.'
    end
  end
end

