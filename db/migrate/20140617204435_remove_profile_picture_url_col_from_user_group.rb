class RemoveProfilePictureUrlColFromUserGroup < ActiveRecord::Migration
  def change
    remove_column :user_groups, :profile_picture_url, :string
  end
end
