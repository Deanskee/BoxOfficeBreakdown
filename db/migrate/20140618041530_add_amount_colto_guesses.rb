class AddAmountColtoGuesses < ActiveRecord::Migration
  def change
  	add_column :guesses, :amount, :integer
  	
  end
end
