class ChangeDescriptionsFromProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :short_description, :text
    change_column :products, :full_description, :text
  end
end
