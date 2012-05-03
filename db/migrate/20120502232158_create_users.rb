class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.integer :uid
      t.string :access_token
      t.string :email
      t.string :image_url
      t.string :full_name

      t.timestamps
    end
  end
end
