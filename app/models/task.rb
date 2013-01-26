class Task < ActiveRecord::Base
  attr_accessible :completed, :completed_datetime, :deadline, :description, :project_id

  belongs_to :project
  validates :project_id, presence: true
  validates :description, presence: true, length: { maximum: 50 }
end
