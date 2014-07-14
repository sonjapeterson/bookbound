class Book < ActiveRecord::Base
	belongs_to_many :groups
end
