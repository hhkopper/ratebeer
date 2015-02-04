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
			beer = create_beer_with_rating_and_style(10, "IPA" , user)

			expect(user.favorite_style).to eq(beer.style)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings_and_style(10, 10, "Lager", user)
			create_beers_with_ratings_and_style(10, 31, 50, "IPA", user)
			create_beers_with_ratings_and_style(10, 50, "Tumma", user)

			expect(user.favorite_style).to eq("IPA")
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

