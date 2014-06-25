require 'rails_helper'

describe UserGroup do
	describe 'data model relationships' do
  	it { should belong_to(:user) }
  	it { should belong_to(:group) }
  	it { should have_db_column(:user_id) }
  	it { should have_db_column(:group_id) }
  end
end