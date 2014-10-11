require 'rails_helper'
require 'pry'

RSpec.describe "Facebook authentication", type: :request do
	describe "signing in" do
		before do 
			visit root_path
			mock_auth_hash
			click_link "Sign in with Facebook"
			binding.pry
		end

		 it "signs in user and redirects to their groups page" do
			expect(page).to have_content("My Books")
			expect(page).to have_content("mock")
		end

	end
end