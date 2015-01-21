class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		
		"Has #{ratings.count} ratings, average #{ratings.average(:score)}" 
	end
end	
