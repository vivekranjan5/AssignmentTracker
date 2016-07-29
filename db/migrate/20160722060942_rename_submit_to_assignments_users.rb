# -*- encoding : utf-8 -*-
class RenameSubmitToAssignmentsUsers < ActiveRecord::Migration
  def up
  	rename_table :submits, :assignments_users
  end

  def down
  	rename_table :assignments_users, :submits
  end
end
