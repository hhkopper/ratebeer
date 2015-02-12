require 'rails_helper'

describe User do
	it "has the username set correctly" do
		user = User.new username:"Pekka"

		expect(user.username).to eq("Pekka")	
	end

	it "is not saved without a password" do
		user = User.create username:"Pekka"

		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	it "is not saved with too short password" do
		user = User.create username:"Pekka", password:"4pU", password_confirmation:"4pU"
		
		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	it "is not saved with password containig only letters" do
		user = User.create username:"Pekka", password:"salasana", password_confirmation:"salasana"

		expect(user.valid?).to be(false)
		expect(User.count).to eq(0)
	end

	describe "with a proper password" do
		let(:user){FactoryGirl.create(:user)}

		it "is saved" do
			expect(user.valid?).to be(true)
			expect(User.count).to eq(1)
		end

		it "and with two ratings, has the correct average rating" do

			user.ratings << FactoryGirl.create(:rating)
			user.ratings << FactoryGirl.create(:rating2)

			expect(user.ratings.count).to eq(2)
			expect(user.average_rating).to eq(15.0)
		end
	end

	describe "favorite beer" do
		let(:user){FactoryGirl.create(:user)}

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_beer)
		end

		it "without ratings does not havea one" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the only rated if only one rating" do
			beer = create_beer_with_rating(10, user)

			expect(user.favorite_beer).to eq(beer)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings(10, 20, 15, 7, 9, user)
			best = create_beer_with_rating(25, user)

			expect(user.favorite_beer).to eq(best)
		end
	end

	describe "favorite style" do 
		let(:user){FactoryGirl.create(:user)}

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_style)
		end

		it "without ratings does not havea one" do
			expect(user.favorite_style).to eq(nil)
		end

		it "is the only rated if only one rating" do
			style = FactoryGirl.create(:style)
			beer = create_beer_with_rating_and_style(10, style , user)

			expect(user.favorite_style).to eq(beer.style)
		end

		it "is the one with highest rating if several rated" do
			style1 = FactoryGirl.create(:style)
			style2 = FactoryGirl.create(:style)
			style3 = FactoryGirl.create(:style)

			create_beers_with_ratings_and_style(10, 10, style1, user)
			create_beers_with_ratings_and_style(10, 31, 50, style2, user)
			create_beers_with_ratings_and_style(10, 50, style3, user)

			expect(user.favorite_style).to eq(style2)
		end		
	end

	describe "favorite brewery" do
		let(:user){FactoryGirl.create(:user)}

		it "has method for determining one" do
			expect(user).to respond_to(:favorite_brewery)
		end

		it "without ratings does not havea one" do
			expect(user.favorite_brewery).to eq(nil)
		end

		it "is the only rated if only one rating" do
			brewery = FactoryGirl.create(:brewery)
			beer = create_beer_with_rating_and_brewery(10, brewery , user)

			expect(user.favorite_style).to eq(beer.style)
		end

		it "is the one with highest rating if several rated" do
			brewery1 = FactoryGirl.create(:brewery)
			brewery2 = FactoryGirl.create(:brewery)
			brewery3 = FactoryGirl.create(:brewery)

			create_beer_with_ratings_and_breweries(10, 31, 50, brewery1, user)
			create_beer_with_ratings_and_breweries(10, brewery2, user)
			create_beer_with_ratings_and_breweries(10, 50, 50, brewery3, user)

			expect(user.favorite_brewery).to eq(brewery3)
		end
	end
end


def create_beer_with_rating(score, user)
	beer = FactoryGirl.create(:beer)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings(*scores, user)
	scores.each do |score|
		create_beer_with_rating(score, user)
	end
end

def create_beer_with_rating_and_style(score, style, user)
	beer = FactoryGirl.create(:beer, style:style)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings_and_style(*scores, style, user)
	scores.each do |score|
		create_beer_with_rating_and_style(score, style, user)
	end
end

def create_beer_with_rating_and_brewery(score, brewery, user)
	beer = FactoryGirl.create(:beer, brewery:brewery)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beer_with_ratings_and_breweries(*scores, brewery, user)
	scores.each do |score|
		create_beer_with_rating_and_brewery(score, brewery, user)
	end
end

