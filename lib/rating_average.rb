module RatingAverage
	def average_rating
		sana = "rating"
		"Has #{ratings.count} #{sana.pluralize(ratings.count)}, average #{ratings.average(:score)}"
	end
end

