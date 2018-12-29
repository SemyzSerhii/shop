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
    link_to 'Publish', publish_admin_review_path(review), method: :put unless review.status
  end

  action_item :unpublish, only: :show do
    link_to 'Unpublish', unpublish_admin_review_path(review), method: :put if review.status
  end

  member_action :publish, method: :put do
    review = Review.find(params[:id])
    review.update(status: true)
    redirect_to admin_review_path(review), notice: 'Review was published.'
  end

  member_action :unpublish, method: :put do
    review = Review.find(params[:id])
    review.update(status: false)
    redirect_to admin_review_path(review), notice: 'Review was unpublished.'
  end
end
