# -*- encoding : utf-8 -*-
class CreateSubmits < ActiveRecord::Migration
  def change
    create_table :submits do |t|
    	t.integer :assignment_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
