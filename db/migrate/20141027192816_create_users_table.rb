class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :ufname
      t.string :ulname
      t.string :uemail
    end
  end
end
