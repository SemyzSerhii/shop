class ReviewsController < ApplicationController
  before_action :set_categories_filters
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_product, only: [ :create, :edit, :update, :destroy]

  include CurrentCart
  before_action :set_cart

  # GET /reviews/new
  def new
    @review = Review.new
  end

  def edit
    redirect_access(root_path) unless check_access(@review)
  end

  # POST /reviews
  # POST /reviews.json
  def create
    if current_user &.access
      params[:review][:user_id] = current_user.id
      @review = @product.reviews.create(review_params)
      @review.status = false
      respond_to do |format|
        if verify_recaptcha(model: @review) && @review.save
          format.html { redirect_to reviews_user_path(current_user), notice: 'Review was successfully created.' }
        else
          format.html { render :_form}
        end
      end
    else
      redirect_access(@product)
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if check_access(@review)
      respond_to do |format|
        @review.status = false
        if verify_recaptcha(model: @review) && @review.update(review_params)
          change_rating
          format.html { redirect_to reviews_user_path(current_user), notice: 'Review was successfully updated.' }
        else
          format.html { render :_form }
        end
      end
    else
      redirect_access(root_path)
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    if check_access(@review)
      @review = @product.reviews.find(params[:id])
      @review.destroy
      respond_to do |format|
        change_rating if @review.status
        format.html { redirect_to reviews_user_path(current_user), notice: 'Review was successfully destroyed.' }
      end
    else
      redirect_access(root_path)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def set_product
    @product = Product.find(params[:product_id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:review).permit(:product_id, :rating, :text, :user_id)
  end

  def change_rating
    @product.update_columns(rating: calculate_rating)
  end

  def calculate_rating
    publish_reviews = @product.reviews.select(&:status)
    if publish_reviews.present?
      sum = publish_reviews.inject(0) { |sum, mark| sum + mark.rating.to_f }
      (sum / publish_reviews.size).round(2) if sum > 0
    else
      0
    end
  end
end
