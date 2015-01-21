class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	def average_rating
		sana = "rating"
		"Has #{ratings.count} #{sana.pluralize(ratings.count)}, average #{ratings.average(:score)}" 
	end

	def to_s
		"#{self.name}, #{self.brewery.name}"
	end
end	
