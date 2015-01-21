class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating
		sana = "rating"
		"Has #{ratings.count} #{sana.pluralize(ratings.count)}, average #{ratings.average(:score)}" 
	end
end	
