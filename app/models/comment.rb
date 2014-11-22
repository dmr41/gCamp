class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :task
  validates :description, presence: true
  
end
