class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :access
      t.string :role
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
