class User < ActiveRecord::Base
  has_and_belongs_to_many :programs

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.full_name = auth["info"]["full_name"]
      user.access_token = auth["credentials"]["token"]
      user.email = auth["info"]["email"]
    end
  end
end