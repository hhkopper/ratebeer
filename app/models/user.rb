class User < ActiveRecord::Base
	include RatingAverage

	validates :username, 	uniqueness: true,
				length: { in: 3..15}
	validates :password,	length: { minimum: 4},
				format: { with: /(?=.*[0-9])(?=.*[A-Z])().+/i, message: "Must contain at least one capital letter and one number!"}

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :memberships, dependent: :destroy
	has_many :beer_clubs, through: :memberships
	has_secure_password

	def to_s
		"#{self.username}"
	end
end
