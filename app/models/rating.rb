class Rating < ActiveRecord::Base
	belongs_to :beer

		def to_s
			b = Beer.find_by id:self.beer_id
			puts "#{b.name} #{self.score}"
		end
end
