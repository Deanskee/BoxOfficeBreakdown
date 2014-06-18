class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|

      t.timestamps
    end
  end
end
