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

  permit_params :title, :price, :short_description, :full_description, :in_stock,
                :category_id, :image_id, tag_list: [],
                images_attributes: [:id, :img, :_destroy]

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

  index as: :block do |product|
    div for: product do
      resource_selection_cell product
      h3  link_to product.title, admin_product_path(product), selecteble: true
      div product.images.present? ? image_tag(product.images.first.img.url(:thumb)) : content_tag(:span, product.short_description)
    end
  end

  show do
    panel "Product" do
      attributes_table_for product do
        row :id
        row :title
        row :price
        row :short_description
        row :full_description do |product|
          product.full_description.html_safe
        end
        row :in_stock
        row :category
        row :created_at
        row :updated_at
        row :rating
        row :tag_list
      end
    end

    if product.images.present?
      panel "Images" do
        table_for product.images do
          column 'Path', :img
          column 'Image' do |product|
            image_tag product.img.url(:thumb)
          end
          column :created_at
          column :updated_at
        end
      end
    end

    if product.reviews.present?
      panel "Reviews" do
        table_for product.reviews do
          column :user
          column :rating do |review|
            link_to(review.rating, admin_review_path(review))
          end
          column :text
          column :created_at
          column :updated_at
        end
      end
    end
    active_admin_comments
  end

  form multipart: true do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :title
        li f.input :price
        li f.input :category_id, as: :select, collection: Category.all
        li do
          f.input :short_description, input_html: { rows: 5 }
        end
        li do
          f.input :full_description, input_html: { class: 'tinymce' }
        end

        f.inputs do
          f.has_many :images, allow_destroy: true do |t|
            t.input :img, as: :file,
                    hint: t.object.img.present? ? image_tag(t.object.img.url(:thumb)) : content_tag(:span, 'No image')
            t.input :img_cache, as: :hidden
          end
        end

        @filters = Filter.all
        @filters.each do |filter|
          h3 filter.title
          f.input :tag_list, as: :check_boxes, multiple: true, collection: filter.tag_list
        end

        li f.input :in_stock, as: :radio
      end
    end
    f.actions
  end

end