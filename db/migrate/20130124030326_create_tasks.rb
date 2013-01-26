class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.datetime :deadline
      t.boolean :completed
      t.datetime :completed_datetime
      t.integer :project_id

      t.timestamps
    end
  end
end
