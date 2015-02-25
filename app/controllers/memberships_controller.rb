class MembershipsController < ApplicationController
		
  	def confirm
		membership = Membership.find(params[:id])
		membership.update_attribute :confirmed, (not membership.confirmed)

		redirect_to :back
  	end

	def index
		@memberships = Membership.all
	end

	def new
		@membership = Membership.new
		@clubs = BeerClub.all
	end

	def destroy
		membership = Membership.find_by id:params["id"]
		club_name = membership.beer_club.name
		membership.destroy
		redirect_to current_user, notice: "Membership in #{club_name} ended."
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
				redirect_to beer_club_path(club_id), notice: "#{current_user.username}, welcome to club!"
			else
				@clubs = BeerClub.all
				render :new
			end
		end
	end
end
