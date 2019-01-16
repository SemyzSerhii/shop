class RemovePreviewImageFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :preview_image, :string
  end
end
