require 'open-uri'
class GroupsController < ApplicationController
  before_action :set_group, :only => [:show, :edit, :update, :destroy]

  respond_to :json, :html

def index
    @groups = Group.all
    
    
end


  def show

    respond_with @group
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      respond_to do |format|
        flash[:success] = "Group successfully created"
        format.html { redirect_to group_path(@group) }
        format.json { render json: @group, status: :created }
      end
    else
      respond_to do |format|
        flash[:danger] = "Group could not be created!"
        format.html { render 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    if @group.update(group_params)
      respond_to do |format|
        format.html { redirect_to group_path(@group) }
        format.json { render nothing: true, status: :no_content }
      end
    else
      respond_to do |format|
        format.html { render 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { render json: :no_content }
    end
  end

  protected

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar, :user_ids => [])
  end

end
