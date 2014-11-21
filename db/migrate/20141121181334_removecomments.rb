class Removecomments < ActiveRecord::Migration
  def change
    remove_column :comments, :commment
    add_column :comments, :description, :text
  end
end
