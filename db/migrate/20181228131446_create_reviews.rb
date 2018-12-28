class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :product, foreign_key: true
      t.integer :rating
      t.string :text
      t.boolean :status

      t.timestamps
    end
  end
end
