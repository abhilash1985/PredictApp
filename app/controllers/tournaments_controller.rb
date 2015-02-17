class TournamentsController < ApplicationController
	before_filter :authenticate_user!

	def show
		@current_challenges = Challenge.where('end_time > ?', DateTime.now)
	end

	def predict_match
		user_challenge = current_user.user_challenges.create(challenge_id:params[:challenge_id])
		params[:match_question].each do |key, value|
			user_challenge.predictions.create(match_question_id:key, user_answer:value)
		end
		respond_to do |format|
			format.js
			format.html
		end
	end
end
