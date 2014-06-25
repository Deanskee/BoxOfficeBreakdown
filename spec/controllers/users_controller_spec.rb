require 'rails_helper'

describe UsersController do
	let (:valid_attributes) {{
		:provider => "a",
		:uid => "b",
		:name => "c",
		:oauth_token => "d"
		}}
	describe 'GET index' do
		before do
			@user1 = User.create! valid_attributes
			@user2 = User.create! valid_attributes
			get :index
		end
		it 'has a 200 status code' do
			expect(response.status).to eq(200)
		end
		it 'should show all users from assigning @users' do
			expect(assigns(:users)).to include(@user1)
			expect(assigns(:users)).to include(@user2)
		end
		it 'should render the index template' do
			expect(response).to render_template :index
		end
	end
end