class ChangeCurrentStatusFromStringToInteger < ActiveRecord::Migration
  def change
	change_column :assignments_users, :current_status, :integer  
  end
end
