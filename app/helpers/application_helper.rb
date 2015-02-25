module ApplicationHelper

	def edit_and_destroy_buttons(item)
		unless current_user.nil?
			edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")
			del = link_to('Destroy', item, method: :delete, data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
			
			raw("#{edit} #{del}")
		end
	end

	def edit_button(item)
		unless current_user.nil?
			edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary")			
			raw("#{edit}")
		end
	end

	def destroy_button(item)
		unless admin_user(current_user).nil?
			del = link_to('Destroy', item, method: :delete, data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
			raw("#{del}")
		end
	end

	def round(number)
		number_with_precision(number, precision: 1)
	end

	def member_of(club, user)
		ship = nil
		if user and user.beer_clubs.include?(club)
			ship = Membership.find_by(user_id:user.id, beer_club_id:club.id)
		end
		ship
	end

end
