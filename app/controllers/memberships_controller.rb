class MembershipsController < ApplicationController
	def index
		@memberships = Membership.all
	end

	def new
		@membership = Membership.new
		@clubs = BeerClub.all
	end

	def create	
		club = params.require(:membership).permit(:beer_club_id)
		club_id = club[:beer_club_id]
		user_id = params[:user_id]

		cl = BeerClub.find_by id:club_id
		users = cl.users
		us = User.find_by id:user_id

		if users.include?(us)
			redirect_to new_membership_path, notice: "You are already a member of #{cl.name}!"
		else
	
			@membership = Membership.new params.require(:membership).permit(:user_id, :beer_club_id)
			if @membership.save
				current_user.memberships << @membership
				redirect_to user_path current_user
			else
				@clubs = BeerClub.all
				render :new
			end
		end
	end
end
