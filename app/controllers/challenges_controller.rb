# ChallengesController
class ChallengesController < ApplicationController
  skip_before_action :current_tournament, only: [:show, :points_table,
                                                 :predictions_table]
  before_action :authenticate_user!
  before_action :challenge_params, only: [:show, :points_table]
  before_action :prediction_challenge_params, only: [:predictions_table]
  before_action :current_tournament_params,  only: [:payment_details, :challenge_payments]

  def payment_details
    # @payments = Payment.includes(:user)
    @users = User.order_by_name.includes(:payments, :challenge_payments, :user_challenges)
  end

  def challenge_payments
    @challenge_payments = ChallengePayment.includes(:user, :challenge)
                                          .order('challenge_payments.id')
  end

  def prize_list
    @prize_lists = Prize.includes(:user).order('prizes.id')
    @challenge_payments = ChallengePayment.oldest
  end

  def show_user_challenges
    @challenges = @current_tournament.challenges.all
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
    redirect_to show_user_challenges_challenge_path(@current_tournament)
  rescue
    flash[:notice] = 'Something Went Wrong'
    redirect_to show_user_challenges_challenge_path(@current_tournament)
  end

  private

  def challenge_params
    current_tournament_params
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.users.order_by_name
  end

  def prediction_challenge_params
    current_tournament_params
    @matches = current_user.matches_for_challenge(@challenge)
    @users = @challenge.started? || current_user.admin ? @challenge.users : [current_user]
  end

  def current_tournament_params
    @challenge = Challenge.find_by_tournament_id(params[:id])
    @current_tournament = @challenge.tournament
    current_tournament_type
  end
end
