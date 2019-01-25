class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true, with: :exception

  include CurrentCart
  before_action :set_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_access(path)
    redirect_to path, alert: 'Access is denied.'
  end

  def check_access(item)
    if current_user
      current_user.access && current_user.id == item.user_id
    else
      false
    end
  end

  def set_categories_filters
    @categories = Category.all
    @filters = Filter.all
    @pages = Page.all
    @settings = Setting.all
    @all_publish_products = Product.all.publish
    @min_price = @all_publish_products.order('price').first.price
    @max_price = @all_publish_products.order('price').last.price
  end

  helper_method :current_user, :redirect_access, :check_access
end
