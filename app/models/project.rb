class Project < ActiveRecord::Base
  attr_accessible :deadline, :description, :user_id

  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 50, minimum: 1 }
end
