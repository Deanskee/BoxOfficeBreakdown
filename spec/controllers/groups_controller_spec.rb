require 'rails_helper'

describe GroupsController, :type => :controller do

	let(:valid_attributes) {{
		:name => 'Millers',
		:description => 'We are the Best!',
		:user_ids => [] 
	}}
	describe 'GET index' do
		before do
			@group1 = Group.create! valid_attributes
			@group2 = Group.create! valid_attributes
			get :index
		end
		it 'has a 200 status code' do
			expect(response.status).to eq(200)
		end
		it 'should show all groups from assigning @groups' do
			expect(assigns(:groups)).to include(@group1)
			expect(assigns(:groups)).to include(@group2)
		end
		it 'should render the index template' do
			expect(response).to render_template :index
		end
	end

	describe 'GET show' do
		before do
			@group = Group.create! valid_attributes
			get :show, id: @group.id
		end
		it 'should be successful' do
			expect(response).to be_success
		end
		it 'should show the right group' do
			expect(assigns(:group)).to eq(@group)
		end
		it 'renders the #show view' do
			expect(response).to render_template :show
		end
	end

	describe 'GET new' do
		before do
			get :new
		end
		it 'should render the new template' do
			expect(response).to render_template :new
		end
		it 'should succeed' do
			expect(response).to be_success
		end
		it 'should assign new group' do
			expect(assigns(:group)).to be_a(Group)
			expect(assigns(:group)).to_not be_persisted
		end
	end

	describe 'POST create' do
		describe 'successful create' do
			it 'should save a new Group to the database' do
				expect do
					post :create, group: valid_attributes
				end.to change(Group, :count).by(1)
			end
			it 'should redirect to the index path' do
				post:create, group: valid_attributes
				expect(response).to redirect_to groups_path
			end
		end
		describe 'with invalid attributes' do
			let(:invalid_attributes) {{
				:name => 'Millers'}}
			it 'does not save the new group' do
				expect do
					post :create, group: invalid_attributes
					response.should render_template :new
				end
			end
			it 're-renders the new method' do
				post :create, group: invalid_attributes
				response.should render_template :new
			end
		end
	end

	describe 'GET edit' do
		before do
			@group = Group.create! valid_attributes
			get :edit, id: @group.id
		end
		it 'should be successful' do
			expect(response).to be_success
		end
		it 'should edit the right group' do
			expect(assigns(:group)).to eq(@group)
		end
		it 'renders the #edit view' do
			expect(response).to render_template :edit
		end
	end

	describe "PUT update" do
		let(:updated_attributes) {{
			:name => 'BobaFet',
			:description => 'Bobafet is the best!'}}
		describe "valid attributes" do
			before do
				@group = Group.create! valid_attributes
				put :update, id: @group.id, group: updated_attributes
			end
			it "locates the requested @group" do 
				expect(assigns(:group)).to eq(@group)
			end
			it 'changes the group attributes' do
				@group.reload
				expect(@group.name).to eq('Cruise')
				expect(@group.description).to eq('Bahamas Baby')
			end
			it 'redirects to the index path' do
				expect(response).to redirect_to groups_path
			end
		end
		describe 'invalid attributes' do
			let :invalid_attributes do
				{
					:name => nil,
					:description => 'Family Time'
				} end
			before do
				@group = Group.create! valid_attributes
				put :update, id: @group.id, group: invalid_attributes
			end
			it 'locates the requested group' do
				expect(assigns(:group)).to eq(@group)
			end
			it 'does not change the group attributes' do
				@group.reload
				expect(@group.name).to_not eq(nil)
			end
			it 're-renders the edit method' do
				expect(response).to render_template :edit
			end
		end
	end

end