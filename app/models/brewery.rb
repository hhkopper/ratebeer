class Brewery < ActiveRecord::Base

	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	
	validate :year_between_past_and_this_year
	validates :name, length: { minimum: 1}

	def year_between_past_and_this_year
		if year < 1042 && year > Time.now.year
			errors.add(:year, "Year must be between 1021 and #{Time.now.year}")
		end
	end

	def print_report
		puts self.name
		puts "established at year #{self.year}"
		puts "number of beers #{self.beers.count}"
	end

	def restart
		self.year = 2015
		puts "changed year to #{year}"
	end

end
