class Note < ActiveRecord::Base
	validates :pagenumber, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 2000}
	validates :body, presence: true

	belongs_to :group
	belongs_to :user
end
