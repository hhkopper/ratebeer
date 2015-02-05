require 'rails_helper'

describe "User page" do
	
	before :each do
		@user = FactoryGirl.create(:user)
		@beer1 = FactoryGirl.create(:beer)
		@beer2 = FactoryGirl.create(:beer, name:'Oma olut')
		rating1 = FactoryGirl.create(:rating, beer:@beer1, user:@user)
		rating2 = FactoryGirl.create(:rating, beer:@beer2, user:@user)
		
	end
	
	it "lists all users ratings" do		

		visit user_path(@user)

		expect(page).to have_content "Has made 2 ratings"
		expect(page).to have_content "#{@beer1.name} 10"
		expect(page).to have_content "#{@beer2.name} 10"
	end

	it "when user is signed in can delete own rating" do
		sign_in(username:"Pekka", password:"Foobar1")

		visit user_path(@user)

		expect{
			page.first('a', text:'delete').click
		}.to change{@user.ratings.count}.from(2).to(1)
	end

	it "shows users favorite beer style when user has ratings" do
		visit user_path(@user)

		expect(page).to have_content 'Your favorite beer style is Lager.'
	end

	it "shows users favorite brewery when user has ratings" do
		visit user_path(@user)

		expect(page).to have_content 'Your favorite brewery is anonymous.'
	end
end
