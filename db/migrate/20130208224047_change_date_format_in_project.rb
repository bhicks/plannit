class ChangeDateFormatInProject < ActiveRecord::Migration
  def up
    change_column :projects, :deadline, :date
  end

  def down
    change_column :projects, :deadline, :datetime
  end
end
