class Request < ActiveRecord::Base
	belongs_to :requester, class_name: "User"
	belongs_to :requested, class_name: "User"
	belongs_to :group 
	validates :requester_id, presence: true
	validates :requested_id, presence: true
	validates :group_id, presence: true
end
