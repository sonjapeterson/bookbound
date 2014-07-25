module GroupsHelper
	def find_matching_users

		userScores = {}
		genreCompatibility = 0
		bookCompatibility = 0
		locationCompatibility = 0
		totalCompatibility = 0

		# find all books read by current user
		currentUserBooks = []
		current_user.groups.each do |group|
			currentUserBooks << group.book
		end

		# iterate through all users in the database
		User.where.not(id: current_user.id).each do |user|

			# calculate compatibility based on genres in common
			Genre.column_names.each do |specificGenre|
				if (current_user.genre[specificGenre] == 1 && user.genre[specificGenre] == 1)
					genreCompatibility += 1
				end
			end

			# normalize genre compatibility score
			genreCompatibility = genreCompatibility.to_f / 13

			# calculate compatibility based on books they have read/are reading
			numberOfBooksInCommon = 0
			user.groups.each do |group|
				if currentUserBooks.include?(group.book)
					numberOfBooksInCommon += 1
				end
			end

			if numberOfBooksInCommon < 10
				bookCompatibility = numberOfBooksInCommon
			else
				bookCompatibility = 10
			end

			# normalize book compatibility score
			bookCompatibility = bookCompatibility.to_f / 10

			#calculate compatibility based on location
			if (!user.location.nil? && !current_user.location.nil?)
				if user.location.split(",")[1].downcase.strip ==  current_user.location.split(",")[1].downcase.strip
					locationCompatibility += 1
					if user.location.split(",")[0].downcase.strip == current_user.location.split(",")[0].downcase.strip
						locationCompatibility += 10
					end
				end
			end

			# normalize location compatibility score
			locationCompatibility = locationCompatibility.to_f / 11

			# weigh the three scores, calculate total compatibility
			totalCompatibility = (0.3 * genreCompatibility + 0.4 * bookCompatibility + 0.3 * locationCompatibility) * 100


			userScores[user] = totalCompatibility.to_f

			# reset compatibility scores
			genreCompatibility = 0
			bookCompatibility = 0
			locationCompatibility = 0
			totalCompatibility = 0
		end


		# return top 10 users
		topMatches = {}
		if User.all.count < 11
			numberOfMatches = User.all.count - 1
		else
			numberOfMatches = 10
		end
		while (topMatches.length < numberOfMatches)
			userWithHighestCompatibility = userScores.key(userScores.values.max)
			topMatches[userWithHighestCompatibility] = userScores.values.max
			userScores.delete(userWithHighestCompatibility)
		end

		return topMatches

	end

end
