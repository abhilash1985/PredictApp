class TournamentsController < ApplicationController
  # include ActionController::Live
	before_filter :authenticate_user!

	def show
		@current_challenges = Challenge.where('end_time > ?', DateTime.now).order(:id).limit(3)
		@previous_challenges = Challenge.previous.order('id desc').page(params[:page]).per(3)
		@prediction = Prediction.new
	end

  def predict_match
    @challenge_id, @match_id = params[:challenge_id], params[:match_id]
    match = Match.find_by_id(@match_id)
    if match && !match.started?
		  user_challenge = current_user.user_challenges.by_challenge(params[:challenge_id]).first_or_initialize
		  user_challenge.save
		  params[:match_question].each do |key, value|
			  prediction = user_challenge.predictions.by_match_question(key).first_or_initialize
        prediction.user_answer = value
        prediction.save
		  end
		end
		respond_to do |format|
			format.js
			format.html
		end
	end

  def update_match
    @challenge_id = params[:challenge_id]
    @match_id = params[:match_id]
    params[:match_question].each do |key, value|
      match_question = MatchQuestion.find_by_id(key)
      next if match_question.nil?
      match_question.answer = value
      match_question.save
    end
  end

  def leaderboard
    tournament = Tournament.find(params[:id])
    @leaderboards = tournament.leaderboard
  end
end
