ActiveAdmin.register Cart do
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

  permit_params :user

  show do
    panel "Cart" do
      attributes_table_for cart do
        row :id
        row :user do |order|
          link_to(order.user.name, shop_admin_user_path(order.user))
        end
        row :created_at
        row :updated_at
      end
    end

    if cart.line_items.present?
      panel "Line_items" do
        table_for cart.line_items do
          column :id do |line_item|
            link_to(line_item.id, shop_admin_line_item_path(line_item))
          end
          column :product do |line_item|
            link_to(line_item.product.title, shop_admin_product_path(line_item.product))
          end
          column :quantity
          column :created_at
          column :updated_at
        end
      end
    end
    active_admin_comments
  end
end
