ActiveAdmin.register Filter do
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

  permit_params :title

  show do
    panel "Filter" do
      attributes_table_for filter do
        row :id
        row :title
        row :created_at
        row :updated_at
      end

      table_for filter.tags do
        column :product
        column :tag
        column :created_at
        column :updated_at
      end
    end
    active_admin_comments
  end

end
