class AddDefaultToPoints < ActiveRecord::Migration
  def change
  	change_column :users, :points, :integer, :default => 5
  end
end
