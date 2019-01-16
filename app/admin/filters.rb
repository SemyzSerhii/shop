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

  permit_params :title, :tag_list

  index do
    selectable_column
    column :id
    column :title, sortable: :title do |filter|
      link_to filter.title, admin_filter_path(filter)
    end
    column :tag_list
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  show do
    panel "Filter" do
      attributes_table_for filter do
        row :id
        row :title
        row :created_at
        row :updated_at
        row :tag_list
      end
    end
    active_admin_comments
  end

  form do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :title
        li do
          f.input :tag_list, input_html: { value: f.object.tag_list.to_s }
        end
      end
    end
    f.actions
  end
end
