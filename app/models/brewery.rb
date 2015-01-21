class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
		puts self.name
		puts "established at year #{self.year}"
		puts "number of beers #{self.beers.count}"
	end

	def restart
		self.year = 2015
		puts "changed year to #{year}"
	end

	def average_rating
		sana = "rating"
		"Has #{ratings.count} #{sana.pluralize(ratings.count)}, average #{ratings.average(:score)}"
	end
end
