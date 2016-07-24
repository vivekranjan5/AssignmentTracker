class AddCurrentStatusToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :current_status, :integer, :default => 0
  end
end
