class ProductsController < ApplicationController

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.select(&:in_stock)
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
