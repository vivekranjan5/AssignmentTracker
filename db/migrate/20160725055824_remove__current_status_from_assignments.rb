# -*- encoding : utf-8 -*-
class RemoveCurrentStatusFromAssignments < ActiveRecord::Migration
  def up
  	remove_column :assignments, :current_status
  end

  def down
  	add_column :assignments, :current_status, :integer
  end
end
