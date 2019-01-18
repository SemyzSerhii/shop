class ProductsController < ApplicationController
  before_action :set_categories_filters

  # GET /products
  # GET /products.json
  def index
    if params[:category]
      @category = Category.find_by_title(params[:category])
      if @category.nil?
        redirect_to root_path, alert: 'Invalid category'
      else
        @products = @category.products
        @category.children.each do |category|
          @products += category.products
        end
      end
    elsif params[:tag]
      @products =  @all_publish_product.tagged_with(params[:tag])
    elsif params[:search]
      @products =  @all_publish_product.search(params[:search])
    else
      @products = @all_publish_product
    end

    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price]
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price]

    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12) if @products.present?

    respond_to do |format|
      format.html
      format.json { render json: @products.pluck(:title) }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Kaminari.paginate_array(@product.reviews.select(&:status)).page(params[:page]).per(10)

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
