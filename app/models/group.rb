class Group < ActiveRecord::Base

  has_many :user_groups
  has_many :users, through: :user_groups

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing_profile.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :name, :description

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
