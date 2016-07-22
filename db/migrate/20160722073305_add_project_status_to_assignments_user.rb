class AddProjectStatusToAssignmentsUser < ActiveRecord::Migration
  def change
  	add_column :assignments_users, :current_status, :string, :default => "Assigned"
  end
end
