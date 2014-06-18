class Movie < ActiveRecord::Base
	has_many :guesses
	has_many :users, through: :guesses
end
