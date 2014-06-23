class UserSerializer < ActiveModel::Serializer
  attributes :id, :provider, :uid, :name, :oauth_token, :points, :level
end
