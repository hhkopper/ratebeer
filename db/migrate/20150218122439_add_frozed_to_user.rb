class AddFrozedToUser < ActiveRecord::Migration
  def change
    add_column :users, :frozed, :boolean
  end
end
