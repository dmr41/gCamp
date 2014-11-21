class Changetextfieldname < ActiveRecord::Migration
  def change
    remove_column :comments, :description
    add_column :comments, :description, :text
  end
end
