class AddMovieRefToGuess < ActiveRecord::Migration
  def change
    add_reference :guesses, :movie, index: true
  end
end
