ActiveAdmin.register User do
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

  permit_params :name, :email, :password, :access

  scope :all
  scope :block
  scope :unblock

  action_item :block, only: :show do
    link_to 'Block', block_shop_admin_user_path(user), method: :put if user.access
  end

  action_item :unblock, only: :show do
    link_to 'Unblock', unblock_shop_admin_user_path(user), method: :put unless user.access
  end

  member_action :block, method: :put do
    user = User.find(params[:id])
    user.update(access: false)
    redirect_to shop_admin_user_path(user), notice: 'User was blocked.'
  end

  member_action :unblock, method: :put do
    user = User.find(params[:id])
    user.update(access: true)
    redirect_to shop_admin_user_path(user), notice: 'User was unblocked.'
  end

  index do
    selectable_column
    column :id
    column :name, sortable: :name do |user|
      link_to user.name, shop_admin_user_path(user)
    end
    column :email
    column :access
    column("Reviews") { |user| user.reviews.size }
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  show do
    panel "User" do
      attributes_table_for user do
        row :id
        row :name
        row :email
        row :access
        row :password_digest
        row :password_reset_token
        row :password_reset_sent_at
        row :created_at
        row :updated_at
      end
    end

    if user.reviews.present?
      panel "Reviews" do
        table_for user.reviews do
          column :rating do |review|
            link_to(review.rating, shop_admin_review_path(review))
          end
          column :text
          column :created_at
          column :updated_at
        end
      end
    end

    if user.orders.present?
      panel "Orders" do
        table_for user.orders do
          column :id do |order|
            link_to order.id, shop_admin_order_path(order)
          end
          column :address
          column :status
          column :comment
          column :created_at
          column :updated_at
        end
      end
    end
    active_admin_comments
  end
end
