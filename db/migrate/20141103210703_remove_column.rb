class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :users, :uemail
  end
end
