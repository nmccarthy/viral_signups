class CreateProgramsUsers < ActiveRecord::Migration
  def up
    create_table :programs_users, :id => false do |t|
      t.integer :program_id
      t.integer :user_id
    end
  end

  def down
  end
end
