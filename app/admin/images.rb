ActiveAdmin.register Image do
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

  permit_params :img, :product_id

  index do
    selectable_column
    column :id
    column :product
    column 'Path', :img
    column 'Image' do |product|
      image_tag product.img.url(:thumb)
    end
    column :created_at
    column :updated_at
    actions dropdown: true
  end

  show do
    panel "Image" do
      attributes_table_for image do
        row :id
        row :product
        row :img
        row 'Image' do |product|
          image_tag product.img.url(:thumb)
        end
        row :created_at
        row :updated_at
      end
      active_admin_comments
    end
  end

  form multipart: true do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :product
        li f.input :img, as: :file,
                   hint: f.object.img.present? ? image_tag(f.object.img.url(:thumb)) : content_tag(:span, 'No image')

      end
    end
    f.actions
  end
end
