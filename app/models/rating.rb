class Rating < ActiveRecord::Base
	belongs_to :beer, touch: true
	belongs_to :user

	validates :score, numericality: { greater_than_or_equal_to: 1,
					less_than_or_equal_to: 50,
					only_integer: true}

	scope :recent, -> {Rating.order("created_at DESC").first(5)}

	def to_s
		b = Beer.find_by id:self.beer_id
		"#{b.name} #{self.score}"
	end

	def usersName
		user = User.find_by id:self.user_id
		"#{user.username}"
	end
end
