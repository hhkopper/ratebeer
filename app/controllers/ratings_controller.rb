class RatingsController < ApplicationController

  before_action :set_information, only: [:index]

	def index
		#Ennen indexia kutsutaan apumetodia set_information, joka asettaa tarvittavat tiedot välimuistiin ja pitää niitä sielä 15min. Tämän jälkeen seuraavan kerran ladattaessa tallentaa tiedot uudelleen muistiin.
	end

	def new
		@rating = Rating.new
		@beers = Beer.all
	end

	def create		
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)
		if current_user.nil?
			redirect_to signin_path, notice:'You should be signed in'
		elsif @rating.save
			current_user.ratings << @rating
			redirect_to user_path current_user
		else
			@beers = Beer.all
			render :new
		end
	end

	def destroy
		rating = Rating.find(params[:id])
		rating.delete if current_user == rating.user
		redirect_to :back
	end

	private
	
	def set_information
		@ratings = Rails.cache.fetch('all_ratings', expires_in: 15.minutes) {Rating.all}
		@recent = Rails.cache.fetch('recents', expires_in: 15.minutes) {Rating.recent}
		@top_breweries = Rails.cache.fetch('top_breweries', expires_in: 15.minutes) {Brewery.top(3)}
		@top_beers = Rails.cache.fetch('top_beers', expires_in: 15.minutes) {Beer.top(3)}
		@users = Rails.cache.fetch('top_users', expires_in: 15.minutes) {User.top(3)}
		@top_styles = Rails.cache.fetch('top_styles', expires_in: 15.minutes) {Style.top(3)}
	end
end
