require 'rails_helper'

describe "Beer" do
	let!(:brewery) {FactoryGirl.create(:brewery)}

	it "is added to datebase when it is created right" do
		visit new_beer_path

		fill_in('beer[name]', with:'Oma olut' )
		select('IPA', from:'beer[style]')
		select(brewery.name, from:'beer[brewery_id]')

		expect{
			click_button "Create Beer"
		}.to change{Beer.count}.from(0).to(1)
	end

	it "is not added to datebase if information is missing" do
		visit new_beer_path

		select('IPA', from:'beer[style]')
		select(brewery.name, from:'beer[brewery_id]')

		click_button "Create Beer"

		expect(Beer.count).to eq(0)
		expect(page).to have_content 'New beer'
		expect(page).to have_content 'Name is too short'
	end

end
