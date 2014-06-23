require 'rails_helper'

describe Group do
  describe 'data model relationships' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
  	it { should have_many(:users) }
	it { should have_many(:user_groups) }
  end
 
end