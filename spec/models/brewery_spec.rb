require 'rails_helper'

describe Brewery do
	it "has the name and year set correctly and is saved to database" do
		brewery = Brewery.create name:"Schlenkerla", year:1674

		expect(brewery.name).to eq("Schlenkerla")
		expect(brewery.year).to eq(1674)
		expect(brewery).to be_valid
	end

	it "without a name is not valid" do
		BeerClub
		BeerClubsController
		MembershipsController
		brewery = Brewery.create year:1674

		expect(brewery).not_to be_valid
	end
end
