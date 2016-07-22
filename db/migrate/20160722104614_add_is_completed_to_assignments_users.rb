class AddIsCompletedToAssignmentsUsers < ActiveRecord::Migration
  def change
  	add_column :assignments_users, :is_compeleted, :boolean, :default => false
  end
end
