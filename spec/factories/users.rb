require 'faker'

FactoryGirl.define do
	factory :user do |f|
		name = Faker::Name.name
		f.fname name.split(" ")[0]
		f.lname name.split(" ")[1]
		f.email Faker::Internet.email
		f.provider "facebook"
		f.uid "1234"
		f.name name
		f.oauth_token "1231alkafj"
	end
end