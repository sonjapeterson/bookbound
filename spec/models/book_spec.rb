require 'spec_helper'

describe Book do

	before do
		@book = FactoryGirl.create(:book)
	end

	subject { @book }

	it { should respond_to(:title) }
	it { should respond_to(:author) }
	it { should respond_to(:pagecount) }
	it { should respond_to(:summary) }

	it "has a valid factory" do
		expect(@book).to be_valid
	end

	it "has a default pagecount of 1000" do
		expect(@book.pagecount).to eq 1000
	end

end