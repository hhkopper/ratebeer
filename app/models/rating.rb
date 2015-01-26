class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user

	def to_s
		b = Beer.find_by id:self.beer_id
		"#{b.name} #{self.score}"
	end
end
