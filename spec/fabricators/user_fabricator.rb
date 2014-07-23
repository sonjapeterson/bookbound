require 'area'

Fabricator(:user) do
	fname { Faker::Name.name.split(" ")[0] }
	lname { Faker::Name.name.split(" ")[1] }
	name { |attrs| "#{attrs[:fname]} #{attrs[:lname]}"}
	email { |attrs| "#{attrs[:fname].parameterize}@example.com" }
	gender { ["female", "male", "other"].sample }
	zipcode { %w(06510 11206 47032 15642 24076 21690 22907 70464 36048 17062 37079 94107 10110 04942 12546 37219 16374 66044 29440).sample }
	location { |attrs| "#{attrs[:zipcode]}".to_region }
	description { "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur." }
	fav_books { "50 Shades of Grey, Twilight" }
	age { (18..40).to_a.sample }
	image { "/assets/defaultProfile.jpg" }
end