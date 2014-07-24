class User < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  VALID_ZIPCODE_REGEX = /\A(\d{5})\z/
  validates :zipcode, format: { with: VALID_ZIPCODE_REGEX }, :allow_blank => true
  VALID_AGE_REGEX = /\A(\d{1,3})\z/
  validates :age, format: { with: VALID_AGE_REGEX }, :allow_blank => true
  validates :description, length: { maximum: 400 }

  has_many :requests, foreign_key: "requester_id",
  							dependent: :destroy
  has_many :requesteds, through: :requests, source: :requested
  has_many :reverse_requests, foreign_key: "requested_id",
                                   class_name:  "Request",
                                   dependent:   :destroy
  has_many :requesters, through: :reverse_requests, source: :requester
  has_and_belongs_to_many :groups
  has_one :genre
  has_many :notifications, dependent: :destroy

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
      auth.info.image ? user.image = auth.info.image : user.image = "/assets/defaultProfile.jpg"
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
