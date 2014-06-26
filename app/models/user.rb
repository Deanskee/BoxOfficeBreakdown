require 'bcrypt'
class User < ActiveRecord::Base
	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.profile_picture_url = auth.info.image 
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
   end

  end

  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :guesses
  has_many :movies, through: :guesses

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :storage => :s3, :default_url => "missing_profile.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create, if: "name.nil?"
  
  def password
      @password
  end

  def password=(new_password)
       @password = new_password
      self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
      if BCrypt::Password.new(self.password_digest) == test_password
        self
      else
        false
      end
  end

  def avatar_url(size)
    self.avatar.url(size)
  end

end
