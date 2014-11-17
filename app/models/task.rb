class Task < ActiveRecord::Base

  validates :description, presence: true
  validates_inclusion_of  :date, {:on => :create, :in =>  (Date.today)..(Date.today + 20.years)}

  belongs_to :project
  
end
