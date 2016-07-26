class ChangesAssingmentsUser < ActiveRecord::Migration
  def up
  	add_column :assignments_users, :assignor_id, :integer
  	rename_column :assignments_users, :user_id, :assignee_id
  end

  def down
  	rename_column :assignments_users, :assignee_id, :user_id
  	remove_column :assignments_users, :assignor_id
  end
end
