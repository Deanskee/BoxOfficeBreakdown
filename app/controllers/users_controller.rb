class UsersController < ApplicationController
  respond_to :json, :html

  def index
    @users = User.all
    respond_with @users  
  end

  def show
    respond_with @users
  end
end

