class AddActualAmountToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :actual_amount, :integer
  end
end
