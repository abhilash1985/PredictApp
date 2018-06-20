# ChallengesController
class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :challenge_params, only: [:show, :points_table]
  before_action :prediction_challenge_params, only: [:predictions_table]

  def payment_details
    @payments = Payment.includes(:user)
  end

  def challenge_payments
    @challenge_payments = ChallengePayment.includes(:user, :challenge)
  end

  private

  def challenge_params
    @challenge = Challenge.find(params[:id])
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.users
  end

  def prediction_challenge_params
    @challenge = Challenge.find(params[:id])
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.started? || current_user.admin ? @challenge.users : [current_user]
  end
end
