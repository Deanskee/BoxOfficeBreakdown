class AddProfilePictureUrlColToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :profile_picture_url, :string
  end
end
