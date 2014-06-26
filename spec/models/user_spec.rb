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

  before do
    @user = User.create!(email: "dan@gmail.com", password: "hey")
  end
   it "is valid with a email, and password" do
    expect(@user).to be_valid
  end
end

