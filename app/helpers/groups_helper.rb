module GroupsHelper
	def find_matching_users

		userScores = {}
		compatibility = 0

		# find all books read by current user
		currentUserBooks = []
		current_user.groups.each do |group|
			currentUserBooks << group.book
		end

		# iterate through all users in the database
		User.where.not(id: current_user.id).each do |user|

			# calculate compatibility based on genres in common
			Genre.column_names.each do |specificGenre|
				if user.genre[specificGenre] == current_user.genre[specificGenre]
					compatibility += 1
				end
			end

			# calculate compatibility based on books they have read/are reading
			user.groups.each do |group|
				if currentUserBooks.include?(group.book)
					compatibility += 2
				end
			end

			#calculate compatibility based on location
			if (!user.location.nil? && !current_user.location.nil?)
				if user.location.split(",")[1].downcase.strip ==  current_user.location.split(",")[1].downcase.strip
					compatibility += 1
					if user.location.split(",")[0].downcase.strip == current_user.location.split(",")[0].downcase.strip
						compatibility += 10
					end
				end
			end

			userScores[user] = compatibility
			compatibility = 0
		end

		# return top 10 users
		topMatches = []
		while (topMatches.length < 10)
			userWithHighestCompatibility = userScores.key(userScores.values.max)
			topMatches << userWithHighestCompatibility
			userScores.delete(userWithHighestCompatibility)
		end

		return topMatches

	end
end
