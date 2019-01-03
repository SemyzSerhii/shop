ActiveAdmin.register Product do
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

  permit_params :title, :price, :short_description, :full_description, :in_stock, :category_id, :image_id,
                images_attributes: [:id, :img, :_destroy],
                tags_attributes: [:id, :filter_id, :tag, :_destroy]

  scope :all
  scope :publish
  scope :unpublish

  action_item :show_shop, only: :show do
    link_to 'Show at the shop', show_shop_admin_product_path(product), method: :put unless product.in_stock
  end

  action_item :hide_in_shop, only: :show do
    link_to 'Hide in the shop', hide_shop_admin_product_path(product), method: :put if product.in_stock
  end

  member_action :show_shop, method: :put do
    product = Product.find(params[:id])
    product.update(in_stock: true)
    redirect_to admin_product_path(product), notice: 'Product at the shop.'
  end

  member_action :hide_shop, method: :put do
    product = Product.find(params[:id])
    product.update(in_stock: false)
    redirect_to admin_product_path(product), notice: 'Product hide in the shop.'
  end

  form multipart: true do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :title
        li f.input :price
        li f.input :category_id, as: :select, collection: Category.all
        li do
          f.label :short_description
          f.text_area :short_description, rows:10
        end
        li do
          f.label :full_description
          f.text_area :full_description, rows: 20
        end

        f.inputs do
          f.has_many :images, allow_destroy: true do |t|
            t.file_field :img
          end
        end

        f.inputs do
          f.has_many :tags, allow_destroy: true do |t|
            t.input :filter_id, as: :select, collection: Filter.all
            t.input :tag
          end
        end

        li f.input :in_stock, as: :radio
      end
    end
    f.actions
  end

end