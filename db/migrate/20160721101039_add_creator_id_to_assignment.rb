class AddCreatorIdToAssignment < ActiveRecord::Migration
  def change
  	add_column :assignments, :creator_id, :integer
  end
end
