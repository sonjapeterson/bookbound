module GroupsHelper
	def find_matching_users
		compatibility = 0
		# iterate through all users in the database
		User.all.each do |user|
			# calculate compatibility based on genres in common
			Genre.column_names.each do |column|
				if user.genre[column] == current_user.genre[column]
					compatibility += 1
				end
			end

			# calculate compatibility based on books they have read/are reading
			user.groups.each 

			#calculate compatibility based on location
			if (!user.location.nil? && !current_user.location.nil?)
				if user.location.split(",")[1].downcase.strip ==  current_user.location.split(",")[1].downcase.strip
					compatibility += 1
					if user.location.split(",")[0].downcase.strip == current_user.location.split(",")[0].downcase.strip
						compatibility += 10
					end
				end
			end
		end
		# calculate a compatibility score for each user based on genres, books they've read, location
		# return top 10 users


		# genres
		# books they have read
		# location
	end
end
