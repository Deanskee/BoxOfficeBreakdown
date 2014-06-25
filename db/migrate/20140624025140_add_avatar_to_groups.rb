class AddAvatarToGroups < ActiveRecord::Migration
    def self.up
    add_attachment :groups, :avatar
  end

  def self.down
    remove_attachment :groups, :avatar
  end
end
