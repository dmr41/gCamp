class ChangeTdateToDateAndRemoveCompeteFalseDefault < ActiveRecord::Migration
  def change
    remove_column :tasks, :tdate, :date
    add_column :tasks, :date, :date
    change_column :tasks, :complete, :boolean
  end
end
