require 'rails_helper'

describe User do
  describe 'data model relationships' do
  	it { should have_many(:groups) }
		it { should have_many(:user_groups) }
		it { should have_db_column(:provider) }
		it { should have_db_column(:uid) }
		it { should have_db_column(:name) }
		it { should have_db_column(:oauth_token) }
		it { should have_db_column(:oauth_expires_at) }
		it { should have_db_column(:points) }
		it { should have_db_column(:level) }

  end
end

