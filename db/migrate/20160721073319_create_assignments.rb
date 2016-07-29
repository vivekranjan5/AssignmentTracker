# -*- encoding : utf-8 -*-
class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
