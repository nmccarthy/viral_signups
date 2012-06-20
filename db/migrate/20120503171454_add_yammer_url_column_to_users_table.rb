class AddYammerUrlColumnToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :yammer_url, :string
  end
end
