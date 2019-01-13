ActiveAdmin.register LineItem do
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

  permit_params :cart_id, :order_id, :quantity, :product

  form do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :cart, input_html: { disabled: true }
        li f.input :order_id, input_html: { disabled: true }
        li f.input :quantity
        li f.input :product
      end
    end
    f.actions
  end
end
