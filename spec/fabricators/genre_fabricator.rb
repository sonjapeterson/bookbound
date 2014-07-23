Fabricator(:genre) do
	user { Fabricate(:user) }
	classic { [0,1].sample }
	comedy { [0,1].sample }
	comic { [0,1].sample }
	educational { [0,1].sample }
	historical { [0,1].sample }
	memoir { [0,1].sample }
	mystery { [0,1].sample }
	nonfiction { [0,1].sample }
	poetry { [0,1].sample }
	pulp { [0,1].sample }
	romance { [0,1].sample }
	scifi { [0,1].sample }
	shortstory { [0,1].sample }
end