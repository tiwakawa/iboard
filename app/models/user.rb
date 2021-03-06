class User < ActiveRecord::Base
  attr_accessible :display_name, :name, :provider, :uid

  has_many :topics
  has_many :comments

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider     = auth["provider"]
      user.uid          = auth["uid"]
      user.name         = auth["info"]["name"]
      user.display_name = auth["info"]["nickname"]
    end 
  end
end
