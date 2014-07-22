class Note < ActiveRecord::Base
	belongs_to :group
	belongs_to :user

	validates :body, presence: true
	validates :pagenumber, presence: true
end
