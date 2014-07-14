class User < ActiveRecord::Base
  has_many :requests, foreign_key: "requester_id", dependent: :destroy
  has_many :requesteds, through: :request, source: :requested
  has_many :reverse_requests, foreign_key: "requested_id",
                                   class_name:  "Request",
                                   dependent:   :destroy
  has_many :requesters, through: :reverse_requests, source: :requester
end
