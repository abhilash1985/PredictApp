class TournamentsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@current_challenges = Challenge.where('end_time > ?', DateTime.now)
	end
end
