require 'rails_helper'

describe Guess do
  describe 'data model relationships' do
    it { should have_db_column(:amount) }
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
    it { should have_db_column(:user_id) }
  	it { should have_db_column(:movie_id) }
  end
end