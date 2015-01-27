class MembershipsController < ApplicationController
	def index
		@memberships = Membership.all
	end

	def new
		@membership = Membership.new
		@clubs = BeerClub.all
	end

	def create		
		@membership = Membership.new params.require(:membership).permit(:user_id, :beer_club_id)
		@membership.save
		#if @membership.save
		#	current_user.beer_clubs << @membership
		#	redirect_to user_path current_user
		#else
		#	@clubs = BeerClub.all
		#	render :new
		#end
		redirect_to memberships_path
	end
end
