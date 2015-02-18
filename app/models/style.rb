class Style < ActiveRecord::Base
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def self.top(n)
		sortable = Style.all.select{ |b| b.average_rating > 0}
		sorted_by_rating_in_desc_order = sortable.sort_by{ |b| -(b.average_rating||0)}
		sorted_by_rating_in_desc_order.first(n)
	end

end
