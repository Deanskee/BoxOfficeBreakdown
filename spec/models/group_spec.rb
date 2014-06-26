require 'rails_helper'

describe Group do
  describe 'data model relationships' do
    it { should have_db_column(:name) }
    it { should have_db_column(:description) }
  	it { should have_many(:users) }
	  it { should have_many(:user_groups) }
  end
  # describe 'validations' do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:description) }
  # end
end