class Createcommmentstables < ActiveRecord::Migration

  def change
    create_table :comments do |t|
      t.text :commment
      t.timestamps
      t.belongs_to :user
      t.belongs_to :task
    end
  end
end
