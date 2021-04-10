# frozen_string_literal: true

# TournamentsController
class TournamentsController < ApplicationController
  # include ActionController::Live
  before_action :authenticate_user!
  before_action :current_tournament

  def show
    if @current_tournament.blank?
      redirect_to root_url, notice: I18n.t('no_tournament_found')
    else
      @current_challenges = @current_tournament.challenges.current.order(:start_time).page(params[:page]).per(4)
      @previous_challenges = @current_tournament.challenges.previous.order('start_time desc').page(params[:page]).per(2)
      @prediction = Prediction.new
    end
  end

  def predict_match
    @challenge_id = params[:challenge_id]
    @match_id = params[:match_id]
    match = Match.find_by_id(@match_id)
    if match && !match.started?
      user_challenge = current_user.user_challenges.by_challenge(params[:challenge_id]).first_or_initialize
      user_challenge.point_booster =
        params[:point_booster] if current_user.point_booster_available? || params[:point_booster].blank?
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
    return unless current_user.admin
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
    @leaderboards = tournament.leader_board
  end

  def select_favourite_team
    @teams = Team.order(:name)
  end

  def prediction_graph
    return root_url if @current_tournament.blank?

    @matches = @current_tournament.matches
    @current_match = @matches.next_matches.first
    show_prediction_graph
  end

  def show_prediction_graph
    @current_match ||= Match.find_by_id(params[:match_id])
    @prediction_graph =
      @current_match.nil? ? [] : @current_match.match_questions.includes(:predictions, :question)
  end

  def update_favourite_team
    if params[:team_id].blank?
      redirect_to select_favourite_team_tournament_path(@current_tournament),
                  notice: I18n.t('favourite_team.no_teams_selected')
    else
      current_user.update(team_id: params[:team_id]) if current_user.team_id.blank?
      redirect_to fan_club_tournament_url(@current_tournament)
    end
  end

  def fan_club
    @leaderboards = @current_tournament.fan_club_leader_board
  end

  def fan_club_members
    @team = current_user.team
  end

  # Old leader_board data
  def leader_board
    tournament = Tournament.find(params[:id])
    @leaderboards = tournament.leaderboard(params[:from])
  end
end
