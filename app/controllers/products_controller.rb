class ProductsController < ApplicationController

  # GET /products
  # GET /products.json
  def index
    if params[:category]
      if @category = Category.find_by_title(params[:category])
        @products = @category.products
      end
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
