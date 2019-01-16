class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :set_key
      t.string :set_value

      t.timestamps
    end
  end
end
