ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Users" do
          table_for User.last(5).each do
            column(:name) { |user| link_to(user.name, admin_user_path(user)) }
            column(:email)
            column("Reviews") { |user| user.reviews.size }
          end
        end

        panel "Recent orders" do
          table_for Order.last(5).each do
            column(:id) { |order| link_to(order.id, admin_order_path(order.id)) }
            column(:user)
            column(:address)
          end
        end
      end

      column do
        panel "Recent Reviews" do
          table_for Review.last(5).each do
            column(:user)
            column(:product)
            column(:text)
            column(:rating) { |review| link_to(review.rating, admin_review_path(review)) }
            column(:status)
          end
        end
      end

      column do
        panel "Recent Products" do
          table_for Product.last(5).each do
            column(:title) { |product| link_to(product.title, admin_product_path(product)) }
            column(:price)
            column("Product") do |product|
              if product.images.present?
                image_tag(product.images.first.img.url(:thumb))
              else
                content_tag(:span, product.short_description)
              end
            end
            column(:in_stock)
            column(:category)
          end
        end
      end

    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
