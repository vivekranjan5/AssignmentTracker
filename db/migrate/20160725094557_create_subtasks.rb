# -*- encoding : utf-8 -*-
class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
    	t.string :subtask_content
    	t.references :assignment
      t.timestamps
    end
  end
end
