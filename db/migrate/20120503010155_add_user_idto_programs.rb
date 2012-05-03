class AddUserIdtoPrograms < ActiveRecord::Migration
  def up
    add_column :programs, :user_id, :integer
  end

  def down
    drop_column :programs, :user_id
  end
end
