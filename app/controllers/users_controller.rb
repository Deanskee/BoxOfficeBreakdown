class UsersController < ApplicationController
  respond_to :json, :html

  before_action :set_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    respond_with @users  
  end

  def new
  	@user = User.new
  end

  def create
     @user = User.new(user_params)
    if @user.save
      respond_to do |format|
      session_create # This method is inhereited from the applicaiton_controller
     format.html  {redirect_to users_path, notice: "Welcome new user."}
     format.json { render json: @user, status: :created}
   end
    else
      respond_to do |format|
      flash[:danger] = "User could not be created"
      format.html {render :new}
      format.json { render json: @user.errors, status: :unprocessable_entity}
    end
    end
  end

  def show
    @guesses = Guess.all
    respond_with @users
  end

  def edit
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
      format.html {redirect_to user_path}
      format.json {render nothing: true, status: :no_content}
      #This doesn't have to stay this path, it's just somewhere to go for now.
    end
    else
      respond_to do |format|
      format.html {redirect_to edit_user_path}
      format.json { render json:@user.errors, status: :unprocessable_entity}
    end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
    format.html {redirect_to new_user_path}
    format.json {render json: :no_content}
  end
  end

 protected
  def set_user
    @user = User.find(params[:id])
  end

	def user_params 
		params.require(:user).permit(:name, :points, :email, :password, :password_confirmation, :level, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size )
	end
end

