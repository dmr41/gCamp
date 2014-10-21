class AddDateFieldToEditNew < ActiveRecord::Migration
  def change
    add_column :tasks, :tdate, :date
  end
end
