ActiveAdmin.register Order do
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

  permit_params :user_id, :address, :status, :comment

  show do
    panel "Order" do
      attributes_table_for order do
        row :id
        row :user do |order|
          link_to(order.user.name, admin_user_path(order.user))
        end
        row "User email" do |order|
          p order.user.email
        end
        row :address
        row :status
        row :comment
        row :created_at
        row :updated_at
      end
    end

    if order.line_items.present?
      panel "Line_items" do
        table_for order.line_items do
          column :id do |line_item|
            link_to(line_item.id, admin_line_item_path(line_item))
          end
          column :product do |line_item|
              link_to(line_item.product.title, admin_product_path(line_item.product))
          end
          column :quantity
          column :created_at
          column :updated_at
        end
      end
    end
    active_admin_comments
  end


  form do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :user, input_html: { disabled: true }
        li f.input :address, input_html: { disabled: true }
        li f.input :status, as: :select, collection: ['In processing', 'Waiting for payment', 'Sent', 'Canceled']
        li f.input :comment
      end
    end
    f.actions
  end
end
