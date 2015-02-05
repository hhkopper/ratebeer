require 'rails_helper'

describe "Ratings page" do

	it "should not have any before been created" do
    		visit ratings_path
    		expect(page).to have_content 'List of ratings'
    		expect(page).to have_content 'Number of ratings: 0'
  	end

	describe "when ratings exists" do
		
		before :each do
      			@user = FactoryGirl.create(:user)
			beer1 = FactoryGirl.create(:beer)
			beer2 = FactoryGirl.create(:beer, name:'Oma olut')
			rating1 = FactoryGirl.create(:rating, beer:beer1, user:@user)
			rating2 = FactoryGirl.create(:rating, beer:beer2, user:@user)

      			visit ratings_path
    		end

		it "lists the ratings and their total number" do
			expect(page).to have_content "Number of ratings: #{Rating.count}"
			expect(page).to have_content "anonymous 10 #{@user.username}"
			expect(page).to have_content "Oma olut 10 #{@user.username}"
		end

	end

end
