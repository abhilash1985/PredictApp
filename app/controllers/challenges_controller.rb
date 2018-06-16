class ChallengesController < ApplicationController
	before_action :authenticate_user!
	before_action :challenge_params, only: [:show, :points_table, :predictions_table]

  private

  def challenge_params
    @challenge = Challenge.find(params[:id])
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.users
  end
end
