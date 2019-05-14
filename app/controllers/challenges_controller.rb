# ChallengesController
class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_tournament
  before_action :challenge_params, only: [:show, :points_table]
  before_action :prediction_challenge_params, only: [:predictions_table]

  def payment_details
    # @payments = Payment.includes(:user)
    @users = User.order_by_name.includes(:payments, :challenge_payments, :user_challenges)
  end

  def challenge_payments
    @challenge_payments = ChallengePayment.includes(:user, :challenge).order('challenges.id')
  end

  def prize_list
    @prize_lists = Prize.includes(:user).order('prizes.id')
    @challenge_payments = ChallengePayment.all
  end

  def show_user_challenges
    @challenges = Challenge.all
    @users = User.order_by_name
  end

  def update_user_challenges
    user_challenge = UserChallenge.by_challenge(params[:challenge])
                                  .by_user(params[:users])
    if user_challenge.blank?
      flash[:notice] = 'No Challenges found'
    else
      user_challenge.update_all(paid: true)
      flash[:notice] = "Updated paid status for #{params[:users]}"
    end
    redirect_to show_user_challenges_challenge_path
  rescue
    flash[:notice] = 'Something Went Wrong'
    redirect_to show_user_challenges_challenge_path
  end

  private

  def challenge_params
    @challenge = Challenge.find(params[:id])
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.users.order_by_name
  end

  def prediction_challenge_params
    @challenge = Challenge.find(params[:id])
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.started? || current_user.admin ? @challenge.users : [current_user]
  end
end
