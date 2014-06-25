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

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing_profile.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    has_attached_file :avatar, 
      :styles => { 
      :medium => "300x300>", 
      :thumb => "100x100>" },
      :storage => :s3,
      :s3_credentials => {
        access_key_id: ENV['ACCESS_KEY_ID'],
        secret_access_key: ENV['SECRET_ACCESS_KEY'],
        bucket: 'deanskee'
      },
      :path => ":attachment/:id/:style.:extension",
      :bucket => "deanskee",
      :default_url => "/images/:style/missing.png"
  
  
  def avatar_url(size)
    self.avatar.url(size).gsub('s3.amazonaws.com/', 's3-us-west-2.amazonaws.com/')
  end
end
