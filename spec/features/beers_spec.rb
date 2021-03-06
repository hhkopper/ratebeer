require 'rails_helper'

describe "Beer" do

	before :each do
		@style = FactoryGirl.create(:style)
		@brewery = FactoryGirl.create(:brewery)
		FactoryGirl.create :user

		sign_in(username:"Pekka", password:"Foobar1")
	end

	it "is added to datebase when it is created right" do

		visit new_beer_path

		fill_in('beer[name]', with:'Oma olut' )
		select(@style.name, from:'beer[style_id]')
		select(@brewery.name, from:'beer[brewery_id]')

		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.from(0).to(1)
	end

	it "is not added to datebase if information is missing" do
		visit new_beer_path

		select(@style.name, from:'beer[style_id]')
		select(@brewery.name, from:'beer[brewery_id]')

		click_button "Create Beer"

		expect(Beer.count).to eq(0)
		expect(page).to have_content 'New beer'
		expect(page).to have_content 'Name is too short'
	end

end
