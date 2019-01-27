ActiveAdmin.register ActsAsTaggableOn::Tag, as: "Tag" do
  permit_params :name, :taggings_count

  show do
    panel "Tag" do
      attributes_table_for tag do
        row :id
        row :name
        row :taggings_count
      end
    end

    if tag.taggings.present?
      panel "Taggings" do
        table_for tag.taggings do
          column :id
          column :taggable_type
          column 'Title' do |tagging|
            link_to tagging.taggable.title, shop_admin_tagging_path(tagging.id)
          end
          column :created_at
        end
      end
    end
    active_admin_comments
  end

  form multipart: true do |f|
    fieldset class: 'inputs' do
      ol do
        li f.input :name

        @products = Product.all
          if @products.present?
            f.input :taggings, as: :check_boxes, multiple: true, collection: @products
          end
      end
    end
    f.actions
  end
end
