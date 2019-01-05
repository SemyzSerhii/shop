ActiveAdmin.register Page do
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

  permit_params :title, :body

  form multipart: true do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :title
        li do
          f.text_area :body, rows: 20, class: 'tinymce'
        end
      end
    end
    f.actions
  end

end
