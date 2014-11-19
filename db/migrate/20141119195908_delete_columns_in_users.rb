class DeleteColumnsInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :ufname
    remove_column :users, :ulname
  end
end
