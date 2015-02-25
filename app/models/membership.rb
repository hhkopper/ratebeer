class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :beer_club

	scope :confirmed, -> {where confirmed:true}
	scope :unconfirmed, -> {where confirmed:[nil, false]}

	def to_s
		u = User.find_by id:self.user_id
		c = BeerClub.find_by id:self.beer_club_id
		"#{u.username} #{c.name}"
	end

end
