class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  has_many :playlists

  def self.find_or_create_from_auth_hash(auth)
    user = self.where( :uid => auth["uid"] ).first

    unless user
      user = create! do |u|
        u.provider = auth["provider"]
        u.uid = auth["uid"]
        u.name = auth["info"]["name"]
        u.nickname = auth["info"]["nickname"]
        u.image = auth["info"]["image"]
      end
    end

    user
  end
end
