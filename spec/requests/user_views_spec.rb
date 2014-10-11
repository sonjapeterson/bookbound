require 'rails_helper'

RSpec.describe "User pages", type: :request do

	describe "Home page" do
		before { visit root_path }
		it "should have the content 'Read with anyone, anywhere'" do
			expect(page).to have_content('Read with anyone, anywhere')
		end
	end
end