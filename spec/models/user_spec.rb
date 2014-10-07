require 'spec_helper'

describe User do

	before do
		@user = FactoryGirl.create(:user)
	end

	it "has a valid factory" do
		expect(@user).to be_valid
	end

	subject { @user }

	it { should respond_to(:fname) }
	it { should respond_to(:lname) }

	describe "when name is not present" do 
		before { @user.name = nil }
		it { should_not be_valid }
	end

	describe "when email is invalid" do
		it "should be invalid" do
			badaddresses = ["bad@notemail,com", "invalid.com", "nope@nope@nope.com"]
			badaddresses.each do |address|
				@user.email = address
				expect(@user).not_to be_valid
			end
		end
	end
	
end