ActiveAdmin.register Review do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :product_id, :user_id, :rating, :text, :status

  scope :all
  scope :publish
  scope :unpublish

  action_item :publish, only: :show do
    link_to 'Publish', publish_shop_admin_review_path(review), method: :put unless review.status
  end

  action_item :unpublish, only: :show do
    link_to 'Unpublish', unpublish_shop_admin_review_path(review), method: :put if review.status
  end

  member_action :publish, method: :put do
    review = Review.find(params[:id])
    review.update(status: true)
    redirect_to shop_admin_review_path(review), notice: 'Review was published.'
  end

  member_action :unpublish, method: :put do
    review = Review.find(params[:id])
    review.update(status: false)
    redirect_to shop_admin_review_path(review), notice: 'Review was unpublished.'
  end

  controller do
    before_action :set_product, only: [:publish, :unpublish, :update, :destroy]
    after_action :change_rating, only: [:publish, :unpublish, :create, :update, :destroy]
    after_action :set_product_create, only: :create


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

    def set_product_create
      @product = Product.find(params[:review][:product_id])
    end

    def set_product
      @review = Review.find(params[:id])
      @product = Product.find(@review.product_id)
    end
  end
end
