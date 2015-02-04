require 'rails_helper'

describe Beer do
	it "is saved when name and style is given" do
		beer = Beer.create name:"Olut", style:"Lager"

		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
	end

	it "is not saved if name is not given" do
		beer = Beer.create style:"Lager"

		expect(Beer.count).to eq(0)
	end

	it "is not saved if style is not given" do
		beer = Beer.create name:"Olut"

		expect(Beer.count).to eq(0)
	end
end
