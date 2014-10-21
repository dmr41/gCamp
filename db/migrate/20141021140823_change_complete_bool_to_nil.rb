class ChangeCompleteBoolToNil < ActiveRecord::Migration
  def change
    change_column :tasks, :complete, :boolean, :default=>nil
  end
end
