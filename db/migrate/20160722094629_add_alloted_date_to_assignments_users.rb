# -*- encoding : utf-8 -*-
class AddAllotedDateToAssignmentsUsers < ActiveRecord::Migration
  def change
  	add_column :assignments_users, :alloted_date, :datetime
  	add_column :assignments_users, :completion_date, :datetime, :default => nil
  end
end
