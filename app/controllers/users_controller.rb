class UsersController < ApplicationController
  respond_to :json, :html

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
      flash[:success] = "Thank you for signing up!"
      session[:remember_token] = @user.id
      @current_user = @user
      redirect_to users_path
    else
      render :new
    end 
  end

  def show
    respond_with @users
  end

private

	def users_params 
		params.require(:group).permit(:name, :points, :level, :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, )
	end
end

