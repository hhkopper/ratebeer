class User < ActiveRecord::Base
	include RatingAverage

	validates :username, 	uniqueness: true,
				length: { in: 3..15}

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships

	def to_s
		"#{self.username}"
	end
end
