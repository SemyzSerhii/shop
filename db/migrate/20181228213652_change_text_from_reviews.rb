class ChangeTextFromReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :text, :text
  end
end
