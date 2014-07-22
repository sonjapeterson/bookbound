class User < ActiveRecord::Base
  has_many :requests, foreign_key: "requester_id",
  							dependent: :destroy
  has_many :requesteds, through: :requests, source: :requested
  has_many :reverse_requests, foreign_key: "requested_id",
                                   class_name:  "Request",
                                   dependent:   :destroy
  has_many :requesters, through: :reverse_requests, source: :requester
  has_and_belongs_to_many :groups
  has_one :genre

  scope :starts_with, -> (lambda) { where("name like ? OR location like ? OR description like ?", "%#{lambda}%", "%#{lambda}%", "%#{lambda}%") }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.fname = auth.info.first_name
      user.lname = auth.info.last_name
      user.name = auth.info.name
      user.email ||= auth.info.email
      user.location ||= auth.info.location
      user.gender ||= auth.extra.raw_info.gender
      user.genre ||= Genre.new
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def show_name_and_image
    name = self.name
    # image = self.image
    # if !image.nil?
    #   return "<img src='#{image}'> #{name}"
    # else
    #   return "#{name}"
    # end
    return "#{name}"
  end

  def set_name_as_value
    self.name
  end

end
