class ProductsController < ApplicationController
  before_action :set_categories_filters

  # GET /products
  # GET /products.json
  def index
    if params[:category]
      if @category = Category.find_by_title(params[:category])
        @products = @category.products
        @category.children.each do |category|
          @products += category.products
        end
      end
    elsif params[:search]
      @products = Product.search(params[:search])
    else
      @products = Product.all.select(&:in_stock)
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews.select(&:status)

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
