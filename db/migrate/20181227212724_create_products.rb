class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.string :short_description
      t.string :full_description
      t.string :preview_image
      t.boolean :in_stock

      t.timestamps
    end
  end
end
