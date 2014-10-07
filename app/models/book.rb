class Book < ActiveRecord::Base
	belongs_to :group
	before_create :default_values

	private
		def default_values
			if self.pagecount == nil
				self.pagecount = 1000
			end
		end
end
