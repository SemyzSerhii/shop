class ProductsController < ApplicationController
  before_action :set_categories_filters
  before_action :last_viewed_products, only: :show
  after_action :set_last_viewed_products, only: :show

  include CurrentCart
  before_action :set_cart

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
      @products = @all_publish_products.tagged_with(params[:tag])
    elsif params[:search]
      @products = @all_publish_products.search(params[:search])
    else
      @products = @all_publish_products
    end

    @products = @products.where('price >= ?', params[:min_price]) if params[:min_price]
    @products = @products.where('price <= ?', params[:max_price]) if params[:max_price]

    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12) if @products

    respond_to do |format|
      format.html
      format.json { render json: @products.pluck(:title) }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @review = Review.new
    @reviews = Kaminari.paginate_array(@product.reviews.select(&:status)).page(params[:page]).per(10)

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def last_viewed_products
    @product = Product.find(params[:id])
    if cookies[:products].present? && cookies[:products] != @product.id.to_s
      last_viewed_products = cookies[:products].to_s.split(',').last(4)
      cookies.delete :products
      cookies[:products] = last_viewed_products.join(',')
      @last_viewed_products = Product.where(id: last_viewed_products)
    end
  end

  def set_last_viewed_products
    if cookies[:products].present?
      cookies[:products] += ", #{@product.id}" unless cookies[:products].include? @product.id.to_s
    else
      cookies[:products] = @product.id
    end
  end
end
