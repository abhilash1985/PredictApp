class ChallengesController < ApplicationController
	before_filter :authenticate_user!

	def index
		
	end

	def show
		@challenge = Challenge.find(params[:id])
	end

end
