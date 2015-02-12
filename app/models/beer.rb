class Beer < ActiveRecord::Base

	include RatingAverage

	belongs_to :brewery
	belongs_to :style
	has_many :ratings, dependent: :destroy
	has_many :raters, through: :ratings, source: :user

	validates :name, length: { minimum: 1}
	validates :style_id, presence: true

	def to_s
		"#{self.name}, #{self.brewery.name}"
	end

	def style_name
		Style.find_by(id:self.style_id).name
	end
end	
