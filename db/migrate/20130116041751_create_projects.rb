class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.datetime :deadline
      t.integer :user_id
      t.string :description

      t.timestamps
    end
  end
end
